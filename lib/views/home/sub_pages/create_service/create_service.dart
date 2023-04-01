import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/buttons.dart';
import 'package:punchmepartner/common/image_picker.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/views/home/pages/services/services_ctrller.dart';

class CreateService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ServicesController controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.yellow,
          title: JxText(
            'Add Offer',
            color: AppColors.black,
          ),
          iconTheme: IconThemeData(color: AppColors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Obx(
                    () => JxImagePicker(
                      isEmpty: controller.imageEmpty.value,
                      imageData: controller.imageBase.value,
                      onSelected: () => controller.showPicker(context),
                      onRemoved: () => controller.removeImage(),
                    ),
                  ),
                  JxSizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                              controller: controller.nameCtrl,
                              decoration: AppStyles.generalTxtField
                                  .copyWith(labelText: 'Offer name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              })),
                      JxSizedBox(
                        width: 3,
                      ),
                      Expanded(
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller.priceCtrl,
                              decoration: AppStyles.generalTxtField.copyWith(
                                  labelText: 'Price',
                                  contentPadding: EdgeInsets.all(15)),
                              validator: (val) => val.isNum ? null : ''))
                    ],
                  ),
                  JxSizedBox(
                    height: 2,
                  ),
                  TextFormField(
                      controller: controller.descriptionCtrl,
                      maxLines: 3,
                      decoration: AppStyles.generalTxtField.copyWith(
                          labelText: 'Description',
                          contentPadding: EdgeInsets.all(15)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                  JxSizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: JxText(
                          'Offer type:',
                          size: 5,
                          color: AppColors.yellow,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => RoundedRectBTN(
                              onTap: () => controller.setServiceType(true),
                              label: 'Punch',
                              toEnable: controller.isPunch.value,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => RoundedRectBTN(
                              onTap: () => controller.setServiceType(false),
                              label: 'Points',
                              toEnable: !controller.isPunch.value,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  JxSizedBox(
                    height: 2,
                  ),
                  Obx(
                    () => Visibility(
                      visible: !controller.isPunch.value,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: JxText(
                          '1 dollar = 1 point',
                          size: 3,
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                  ),
                  JxSizedBox(),
                  Row(
                    children: [
                      Expanded(
                          child: Obx(
                        () => TextFormField(
                            keyboardType: TextInputType.number,
                            controller: controller.doItCtrl,
                            decoration: AppStyles.generalTxtField.copyWith(
                                labelText: controller.isPunch.value
                                    ? 'Scan For'
                                    : 'Collect points',
                                contentPadding: EdgeInsets.all(15)),
                            validator: (val) => val.isNum ? null : ''),
                      )),
                      JxSizedBox(
                        width: 3,
                      ),
                      Expanded(
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller.getItCtrl,
                              decoration: AppStyles.generalTxtField.copyWith(
                                  labelText: 'And get',
                                  contentPadding: EdgeInsets.all(15)),
                              validator: (val) => val.isNum ? null : '')),
                    ],
                  ),
                  JxSizedBox(
                    height: 1.5,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isPunch.value,
                      child: Row(
                        children: [
                          Expanded(
                              child: JxText(
                            'Select End date:',
                            size: 5,
                          )),
                          JxSizedBox(
                            width: 3,
                          ),
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
                                    controller.pickDate(context, 2),
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
                    ),
                  ),
                  JxSizedBox(
                    height: 2,
                  ),
                  TextIconBTN(
                    onPressed: () => controller.create(),
                    enabled: true,
                    label: 'Add Offer',
                    icondata: Icons.add,
                  ),
                  JxSizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
