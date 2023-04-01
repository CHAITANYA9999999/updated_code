import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/routes/routes.dart';

import 'package:punchmepartner/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  static const id = 'landing';

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final saved = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 0), () async {
      if (user == null) {
        saved.clear();
        // user = null;
        Get.offAndToNamed(Routes.decider);
      } else {
        Get.offAndToNamed(Routes.pager);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Center(
      child: Text('Punch ME',
          style: AppStyles.idleTxt.copyWith(color: AppColors.yellow)),
    ));
  }
}
