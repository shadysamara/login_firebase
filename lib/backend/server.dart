import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/backend/appGet.dart';
import 'package:login_firebase/ui/splach.dart';
import 'package:login_firebase/utilities/custom_dialoug.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
AppGet appGet = Get.find();
Future<String> registerNewUserUsingEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    getUserProfile();
    return userCredential.user.uid;
  } catch (e) {
    hideProgressDialoug(false);
    return null;
  }
}

Future<String> signInUsingEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    getUserProfile();
    return userCredential.user.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      paintCustomDialoug('Not Found', 'the email you enterd has not been found',
          () => Get.back());
    } else if (e.code == 'wrong-password') {
      paintCustomDialoug('Wrong Password',
          'Wrong password provided for that user.', () => Get.back());
    }
    return null;
  }
}

signOut() async {
  await auth.signOut();
  appGet.userMap.value = {};
  Get.offAll(SplachScreen());
}

saveUserProfile(
    {String email,
    String password,
    String userName,
    String phoneNumber,
    File image,
    String city}) async {
  showProgressDialoug();
  try {
    String userId = await registerNewUserUsingEmailAndPassword(email, password);
    assert(userId != null);
    String url = await uploadNewImage(image);

    firestore.collection('users').doc(userId).set({
      "email": email,
      "userName": userName,
      "phoneNumber": phoneNumber,
      "imageUrl": url,
      "useriD": userId,
      "city": city,
      "isAdmin": false
    });
    hideProgressDialoug(true);
  } on Exception catch (e) {
    hideProgressDialoug(false);
  }
}

Future<Map> getUserProfile() async {
  try {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(auth.currentUser.uid).get();
    Map map = documentSnapshot.data();
    appGet.userMap.value = map;
    print(map);
    return documentSnapshot.data();
  } on Exception catch (e) {
    return null;
  }
}

updateUserProfile({String userName, String phoneNumber, String city}) async {
  try {
    String url = appGet.file != null ? await uploadNewImage(appGet.file) : null;
    Map map = url != null
        ? {
            "userName": userName,
            "phoneNumber": phoneNumber,
            "imageUrl": url,
            "city": city
          }
        : {"userName": userName, "phoneNumber": phoneNumber, "city": city};

    await firestore
        .collection('users')
        .doc(auth.currentUser.uid)
        .update({...map});
    getUserProfile();
  } on Exception catch (e) {}
}

Future<String> uploadNewImage(File file) async {
  String imageName = file.path.split('/').last;
  Reference ref = storage.ref().child('profileImages').child(imageName);
  TaskSnapshot uploadTask = await ref.putFile(file);
  String url = await ref.getDownloadURL();
  return url;
}

String checkIfUserExists() {
  String id = auth.currentUser != null ? auth.currentUser.uid : null;
  return id;
}

pickImage() async {
  try {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    appGet.setNewFile(File(pickedFile.path));
  } on Exception catch (e) {
    paintCustomDialoug(
        'error', 'you have denied our service', () => Get.back());
  }
}
