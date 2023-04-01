import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/buttons.dart';
import 'package:punchmepartner/common/content_divider.dart';
import 'package:punchmepartner/common/header.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'register_controller.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: Stack(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JxSizedBox(
                        height: 25,
                      ),
                      JxText('New registration & request',
                          size: 6, color: AppColors.yellow, isBold: true),
                      JxSizedBox(),
                      ContentDivider(
                        title: 'Owner Details',
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: controller.ownerEmailCtrl,
                            decoration: AppStyles.generalTxtField
                                .copyWith(labelText: 'Owner\'s email'),
                            validator: (val) => val.isEmail ? null : '',
                          )),
                          JxSizedBox(),
                          Expanded(
                              child: TextFormField(
                            controller: controller.ownerNameCtrl,
                            decoration: AppStyles.generalTxtField
                                .copyWith(labelText: 'Owner\'s name'),
                            validator: (val) {
                            if (val == null || val == '') {
                              return '';
                            }
                            return null;
                          },
                          ))
                        ],
                      ),
                      JxSizedBox(),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                  controller: controller.ownerPhoneCtrl,
                                  decoration: AppStyles.generalTxtField
                                      .copyWith(labelText: 'Owner\'s phone'),
                                  validator: (val) =>
                                      val.isPhoneNumber ? null : '')),
                          JxSizedBox(),
                          Expanded(child: Container())
                        ],
                      ),
                      JxSizedBox(),
                      ContentDivider(
                        title: 'Store Details',
                      ),
                      TextFormField(
                          controller: controller.nameCtrl,
                          decoration: AppStyles.generalTxtField
                              .copyWith(labelText: 'Name'),
                          validator: (val) {
                            if (val == null || val == '') {
                              return '';
                            }
                            return null;
                          }

                          // val.isNotEmpty ? null : ''
                          ),
                      JxSizedBox(),
                      TextFormField(
                          controller: controller.descriptionCtrl,
                          maxLines: 3,
                          decoration: AppStyles.generalTxtField.copyWith(
                              labelText: 'Description',
                              contentPadding: EdgeInsets.all(15)),
                          validator: (val) {
                            if (val == null || val == '') {
                              return '';
                            }
                            return null;
                          }
                          // val.isNotEmpty ? null : ''
                          ),
                      JxSizedBox(),
                      TextFormField(
                          controller: controller.addressCtrl,
                          maxLines: 3,
                          decoration: AppStyles.generalTxtField.copyWith(
                              labelText: 'Address',
                              contentPadding: EdgeInsets.all(15)),
                          validator: (val) {
                            if (val == null || val == '') {
                              return '';
                            }
                            return null;
                          }),
                      JxSizedBox(),
                      TextFormField(
                          controller: controller.provinceCtrl,
                          decoration: AppStyles.generalTxtField.copyWith(
                              labelText: 'Province',
                              contentPadding: EdgeInsets.all(15)),
                          validator: (val) {
                            if (val == null || val == '') {
                              return '';
                            }
                            return null;
                          }),
                      JxSizedBox(),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: JxText('Store timings', size: 3.5),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => MaterialButton(
                                shape: AppStyles.minimalBorder.copyWith(
                                    side: BorderSide(
                                        width: 1,
                                        color: controller.errText.value != ''
                                            ? AppColors.red
                                            : controller.startTime.value
                                                    .contains('Select')
                                                ? AppColors.white
                                                : AppColors.yellow)),
                                onPressed: () =>
                                    controller.pickTime(context, 1),
                                splashColor: AppStyles.splashYellow,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: JxText(controller.startTime.value,
                                      size: 4,
                                      color: controller.startTime.value
                                              .contains('Select')
                                          ? AppColors.white
                                          : AppColors.yellow),
                                )),
                              ),
                            ),
                          ),
                          JxText('  -  ',
                              size: 4, color: AppColors.yellow, isBold: true),
                          Expanded(
                            child: Obx(
                              () => MaterialButton(
                                shape: AppStyles.minimalBorder.copyWith(
                                    side: BorderSide(
                                        width: 1,
                                        color: controller.errText.value != ''
                                            ? AppColors.red
                                            : controller.endTime.value
                                                    .contains('Select')
                                                ? AppColors.white
                                                : AppColors.yellow)),
                                onPressed: () =>
                                    controller.pickTime(context, 2),
                                splashColor: AppStyles.splashYellow,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: JxText(controller.endTime.value,
                                      size: 4,
                                      color: controller.endTime.value
                                              .contains('Select')
                                          ? AppColors.white
                                          : AppColors.yellow),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      JxSizedBox(
                        height: 3,
                      ),
                      TextIconBTN(
                        onPressed: () => controller.register(),
                        enabled: true,
                        label: 'Send Request',
                        icondata: Icons.navigate_next,
                      ),
                      JxSizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          HeaderClipped(),
        ],
      ),
    );
  }
}
