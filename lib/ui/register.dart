import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/backend/appGet.dart';
import 'package:login_firebase/backend/server.dart';
import 'package:login_firebase/ui/widgets/custom_textField.dart';
import 'package:login_firebase/utilities/custom_dialoug.dart';

class RegisterScreen extends StatelessWidget {
  AppGet appGet = Get.find();
  String email;
  String password;
  String password2;
  String userName;
  String phone;
  String city;
  File file;
  saveEmail(String value) {
    this.email = value;
  }

  savepassword(String value) {
    this.password = value;
  }

  savepassword2(String value) {
    this.password2 = value;
  }

  saveuserName(String value) {
    this.userName = value;
  }

  savephone(String value) {
    this.phone = value;
  }

  savecity(String value) {
    this.city = value;
  }

  String nullValidator(String value) {
    if (value.length == 0 || value == null || value == '') {
      return 'Required Field';
    }
  }

  String conformPasswordValidation(String value) {
    if (password2 != password) {
      return 'error matching passwords';
    }
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

  GlobalKey<FormState> registerKey = GlobalKey();
  saveForm() {
    if (registerKey.currentState.validate()) {
      registerKey.currentState.save();
      saveUserProfile(
          city: this.city,
          email: this.email,
          image: appGet.file,
          password: this.password,
          phoneNumber: this.phone,
          userName: this.userName);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: registerKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                label: 'Email',
                saveFun: saveEmail,
                validateFun: nullValidator,
              ),
              CustomTextField(
                label: 'User Name',
                saveFun: saveuserName,
                validateFun: nullValidator,
              ),
              CustomTextField(
                label: 'Phone',
                saveFun: savephone,
                validateFun: nullValidator,
              ),
              CustomTextField(
                label: 'City',
                saveFun: savecity,
                validateFun: nullValidator,
              ),
              CustomTextField(
                label: 'Password',
                saveFun: savepassword,
                validateFun: nullValidator,
              ),
              CustomTextField(
                label: 'Retype password',
                saveFun: savepassword2,
                validateFun: conformPasswordValidation,
              ),
              GetBuilder<AppGet>(
                init: AppGet(),
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      child: controller.file != null
                          ? Image.file(
                              appGet.file,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.add),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                    child: Text('Register'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      saveForm();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
