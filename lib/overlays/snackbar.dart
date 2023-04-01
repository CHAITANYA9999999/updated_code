import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/res/app_colors.dart';

class JxSnackBarStatus {
  JxSnackBarStatus(String title, String text) {
    Get.snackbar(title == '' ? 'Oops' : title, text == '' ?  'Something went wrong...' : text,
        borderRadius: 0,
        margin: EdgeInsets.all(0),
        backgroundColor: AppColors.darkGrey,
        snackPosition: SnackPosition.BOTTOM,
        colorText: AppColors.yellow,
        isDismissible: false);
  }
}

class JxSnackBarLoading {
  JxSnackBarLoading(bool isLoading) {
    isLoading
        ? Get.snackbar('Please wait...', '',
            borderRadius: 0,
            margin: EdgeInsets.all(0),
            duration: Duration(seconds: 1000),
            backgroundColor: AppColors.darkGrey,
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColors.yellow,
            showProgressIndicator: isLoading,
            isDismissible: false)
        : Get.back();
  }
}
