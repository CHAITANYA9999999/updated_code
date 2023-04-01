import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/buttons.dart';
import 'package:punchmepartner/common/header.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'decider_controller.dart';

class Decider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeciderController());
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: SafeArea(
          child: Stack(
        children: [
          BackgroundImage(),
          HeaderClipped(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              JxSizedBox(
                height: 20,
              ),
              JxText('Hello there!',
                  size: 10, color: AppColors.yellow, isBold: true),
              JxText('Please choose an option:',
                  size: 5.5, color: AppColors.yellow),
              JxSizedBox(
                height: 4,
              ),
              TextIconBTN(
                enabled: true,
                onPressed: () => controller.toLogin(),
                label: 'Login',
                icondata: Icons.navigate_next,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: JxText('or', size: 3.5, isBold: true),
                ),
              ),
              TextIconBTN(
                enabled: true,
                onPressed: () => controller.toRegister(),
                label: 'Register',
                icondata: Icons.navigate_next,
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
