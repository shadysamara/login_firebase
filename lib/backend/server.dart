import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/utilities/custom_dialoug.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<String> registerNewUserUsingEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      paintCustomDialoug('Weak Password',
          'you have to enter 6 characters at least', () => Get.back());
    } else if (e.code == 'email-already-in-use') {
      paintCustomDialoug('Already Used',
          'The account already exists for that email.', () => Get.back());
    }
    return null;
  } catch (e) {
    paintCustomDialoug('Error', e.toString(), () => Get.back());
    return null;
  }
}

Future<String> signInUsingEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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

signOut() {
  auth.signOut();
}

saveUserProfile(
    {String email,
    String password,
    String userName,
    String phoneNumber,
    File image,
    String city}) async {
  String url = await uploadNewImage(image);
  String userId = await registerNewUserUsingEmailAndPassword(email, password);
  try {
    firestore.collection('users').doc(userId).set({
      "email": email,
      "userName": userName,
      "phoneNumber": phoneNumber,
      "imageUrl": url,
      "useriD": userId,
      "city": city,
      "isAdmin": false
    });
  } on Exception catch (e) {
    paintCustomDialoug('error', e.toString(), () => Get.back());
  }
}

getUserProfile() async {}
updateUserProfile(Map map) async {}
Future<String> uploadNewImage(File file) async {
  String imageName = file.path.split('/').last;
  Reference ref = storage.ref().child('profileImages').child(imageName);
  TaskSnapshot uploadTask = await ref.putFile(file);
  String url = await ref.getDownloadURL();
  return url;
}
