import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/buttons.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/utils/size_config.dart';

class JxDialog {
  JxDialog(String title, String text, String posLabel, String negLabel,
      Function? onPos, Function? onNeg) {
    Get.dialog(
        Scaffold(
            backgroundColor: AppColors.transparent,
            body: Center(
              child: Container(
                width: SizeConfig.width * 80,
                padding: EdgeInsets.all(15),
                color: AppColors.darkGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JxText(title == '' ? 'Oops' : text,
                        size: 4.5, isBold: true, color: AppColors.yellow),
                    JxSizedBox(),
                    JxText(
                      text == '' ? 'Something went wrong ...' : text,
                      size: 4,
                      maxLines: 6,
                    ),
                    JxSizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                            visible: negLabel != '',
                            child: TextBTN(
                              onPressed: () =>
                                  onNeg == null ? Get.back() : onNeg(),
                              enabled: true,
                              label: negLabel,
                              isDark: true,
                              textSize: 4,
                            )),
                        JxSizedBox(),
                        TextBTN(
                          onPressed: () => onPos == null ? Get.back() : onPos(),
                          enabled: true,
                          label: posLabel == '' ? 'OK' : posLabel,
                          isDark: true,
                          textSize: 4,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
        barrierDismissible: false);
  }

  static void dimiss() => Get.back();
}
