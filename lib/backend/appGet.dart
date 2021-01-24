import 'dart:io';

import 'package:get/get.dart';

class AppGet extends GetxController {
  File file;
  var userMap = {}.obs;
  var editingMode = false.obs;
  setNewFile(File file) {
    this.file = file;
    update();
  }
}
