import 'package:flutter/material.dart';
import 'package:get/get.dart';

void isLoading(bool status) {
  status
      ? Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false)
      : Get.back();
}
