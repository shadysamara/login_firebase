import 'package:flutter/material.dart';
import 'package:get/get.dart';

paintCustomDialoug(String title, String content, Function conformFun) {
  Get.defaultDialog(
    title: title,
    content: Text(content),
    textConfirm: 'OK',
    confirmTextColor: Colors.white,
    onConfirm: conformFun,
  );
}
