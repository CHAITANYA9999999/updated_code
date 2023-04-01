import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static final idleTxt = TextStyle(
      fontFamily: 'MavenPro',
      fontSize: 18,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);

  static final btnTxt = TextStyle(
      fontFamily: 'MavenPro',
      fontWeight: FontWeight.bold,
      color: AppColors.black,
      fontSize: 20,
      decoration: TextDecoration.none);

  static final generalTxtField = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
    errorStyle: TextStyle(fontSize: 0.1),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.yellow, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.yellow, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8))),
  );
  static final minimalBorderRadius = BorderRadius.all(Radius.circular(10));

  static final minimalBorder =
      RoundedRectangleBorder(borderRadius: minimalBorderRadius);

  static final splashYellow = AppColors.yellow.withOpacity(0.1);

  static final splashBlue = AppColors.blue.withOpacity(0.05);
  static final hoverBlue = AppColors.blue.withOpacity(0.2);
}
