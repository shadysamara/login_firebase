import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/ui/profile_page.dart';

paintCustomDialoug(String title, String content, Function conformFun) {
  Get.defaultDialog(
    title: title,
    content: Text(content),
    textConfirm: 'OK',
    confirmTextColor: Colors.white,
    onConfirm: conformFun,
  );
}

showProgressDialoug() {
  Get.defaultDialog(
    title: 'loading',
    content: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

hideProgressDialoug(bool success) {
  success
      ? paintCustomDialoug('success', 'your account has been created', () {
          Get.off(ProfilePage());
        })
      : paintCustomDialoug('failed', 'your account has not been created', () {
          Get.back();
          Get.back();
        });
}
