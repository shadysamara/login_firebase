import 'dart:io';

import 'package:get/get.dart';

class AppGet extends GetxController {
  File file;

  setNewFile(File file) {
    this.file = file;
    update();
  }
}
