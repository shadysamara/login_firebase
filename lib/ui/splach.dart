import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/backend/appGet.dart';
import 'package:login_firebase/ui/register.dart';

class SplachScreen extends StatelessWidget {
  AppGet appGet = Get.put(AppGet());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2))
        .then((value) => Get.off(RegisterScreen()));
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('SPLACH'),
      ),
    );
  }
}
