import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/backend/appGet.dart';
import 'package:login_firebase/ui/profile_page.dart';
import 'package:login_firebase/ui/register.dart';
import 'package:login_firebase/backend/server.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  AppGet appGet = Get.put(AppGet());
  String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = checkIfUserExists();
    if (userId != null) {
      getUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      userId == null ? Get.off(RegisterScreen()) : Get.off(ProfilePage());
    });

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('SPLACH'),
      ),
    );
  }
}
