import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/utils/size_config.dart';

class JxWDialog extends StatelessWidget {
  const JxWDialog({
    required this.title,
    required this.formKey,
    required this.child,
  });
  final String title;
  final Key formKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          color: AppColors.darkGrey,
          margin: EdgeInsets.all(20),
          width: SizeConfig.width * 30,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                color: AppColors.yellow,
                child: Row(
                  children: [
                    JxSizedBox(),
                    JxText(
                      title,
                      size: 1.2,
                      isBold: true,
                      color: AppColors.darkerGrey,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close),
                      color: AppColors.darkerGrey,
                    )
                  ],
                ),
              ),
              JxSizedBox(),
              Expanded(
                  child: Form(
                key: formKey,
                child: child,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
