import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/backend/appGet.dart';
import 'package:login_firebase/backend/server.dart';
import 'package:login_firebase/ui/profile_page.dart';
import 'package:login_firebase/ui/register.dart';
import 'package:login_firebase/ui/widgets/custom_textField.dart';
import 'package:login_firebase/utilities/custom_dialoug.dart';

class LoginScreen extends StatelessWidget {
  AppGet appGet = Get.find();
  String email;
  String password;

  saveEmail(String value) {
    this.email = value;
  }

  savepassword(String value) {
    this.password = value;
  }

  String nullValidator(String value) {
    if (value.length == 0 || value == null || value == '') {
      return 'Required Field';
    }
  }

  GlobalKey<FormState> loginKey = GlobalKey();
  saveForm() async {
    if (loginKey.currentState.validate()) {
      loginKey.currentState.save();
      String id = await signInUsingEmailAndPassword(email, password);
      if (id != null) {
        Get.offAll(ProfilePage());
      }
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
        key: loginKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                label: 'Email',
                saveFun: saveEmail,
                validateFun: nullValidator,
              ),
              CustomTextField(
                label: 'Password',
                saveFun: savepassword,
                validateFun: nullValidator,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                    child: Text('Sign in'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      saveForm();
                    }),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(RegisterScreen());
                },
                child: Text(
                  'Go to Register',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
