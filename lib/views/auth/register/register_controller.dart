import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/apis/register_request.dart';
import 'package:punchmepartner/models/store_m.dart';
import 'package:punchmepartner/overlays/dialog.dart';
import 'package:punchmepartner/overlays/snackbar.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/date_time.dart';

class RegisterController extends GetxController {
  RegisterRequestsRepo registerRequestsRepo = RegisterRequestsApis();
  final formKey = GlobalKey<FormState>();
  final ownerEmailCtrl = TextEditingController();
  final ownerNameCtrl = TextEditingController();
  final ownerPhoneCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final storeMapLinkCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final provinceCtrl = TextEditingController();

  final startTime = 'Select start time'.obs;
  final endTime = 'Select end time'.obs;
  final errText = ''.obs;
  final isLoading = false.obs;

  void register() async {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        if (startTime.value.contains('Select') &&
            endTime.value.contains('Select')) {
          errText.value = 'Select timings';
          return;
        }
        errText.value = '';
        final storeM = StoreM(
          date: setDate(),
          email: ownerEmailCtrl.text,
          ownerName: ownerNameCtrl.text,
          phone: ownerPhoneCtrl.text,
          name: nameCtrl.text,
          description: descriptionCtrl.text,
          address: addressCtrl.text,
          province: provinceCtrl.text,
          timings: startTime.value + '::' + endTime.value,
          status: false,
          banFor: '',
        );
        try {
          isLoading.value = true;
          JxSnackBarLoading(isLoading.value);
          await registerRequestsRepo.register(storeM);
          isLoading.value = false;
          JxSnackBarLoading(isLoading.value);
          clearFields();
          JxDialog(
              'Confirmation',
              'Your Registration has been done!, and request has been received, Our team will soonly contact you',
              '',
              '',
              null,
              null);
        } catch (e) {
          print(e);
          isLoading.value = false;
          JxSnackBarLoading(isLoading.value);
          JxDialog('', '', '', '', null, null);
        }
      }
    }
  }

  void pickTime(context, int i) async {
    TimeOfDay selectedTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 00, minute: 00),
      builder: (_, child) {
        return Theme(
          child: child!,
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.yellow,
              primaryColorDark: AppColors.yellow,
            ),
            timePickerTheme: TimePickerTheme.of(context).copyWith(
                hourMinuteColor: AppStyles.splashYellow,
                dialTextColor: AppColors.yellow,
                dialHandColor: AppColors.yellow.withOpacity(0.15),
                backgroundColor: AppColors.darkGrey),
          ),
        );
      },
    );
    if (picked != null) {
      selectedTime = picked;
      String time = formatDate(
          DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
          [hh, ':', nn, " ", am]).toString();
      if (i == 1) {
        startTime.value = time;
      } else if (i == 2) {
        endTime.value = time;
      }
    }
  }

  void clearFields() {
    ownerEmailCtrl.text = '';
    ownerNameCtrl.text = '';
    ownerPhoneCtrl.text = '';
    nameCtrl.text = '';
    descriptionCtrl.text = '';
    storeMapLinkCtrl.text = '';
    addressCtrl.text = '';
    provinceCtrl.text = '';
    startTime.value = 'Select start time';
    endTime.value = 'Select end time';
  }
}
