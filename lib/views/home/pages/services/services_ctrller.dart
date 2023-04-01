import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:punchmepartner/apis/services.dart';
import 'package:punchmepartner/models/service_m.dart';
import 'package:punchmepartner/overlays/dialog.dart';
import 'package:punchmepartner/overlays/progress_dialog.dart';
import 'package:punchmepartner/overlays/snackbar.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/converts.dart';
import 'package:punchmepartner/utils/date_time.dart';
import 'package:punchmepartner/utils/location.dart';
import 'package:punchmepartner/views/home/pager_ctrller.dart';

class ServicesController extends GetxController {
  ServicesRepo servicesRepo = ServicesApis();
  final PageCtrller pageCtrller = Get.find();
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final doItCtrl = TextEditingController();
  final getItCtrl = TextEditingController();
  bool isUpdate = false;
  late ServiceM storeM;

  final imageBase = ''.obs;
  final imageFile = <dynamic>[].obs;
  final imageEmpty = false.obs;
  final isPunch = true.obs;
  final endTime = 'Select'.obs;
  final errText = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Camera'),
                      onTap: () {
                        pickImage(0);
                        Get.back();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Gallery'),
                    onTap: () {
                      pickImage(1);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickImage(int type) async {
    ImageSource source;
    source = type == 0 ? ImageSource.camera : ImageSource.gallery;
    // File image = await ImagePicker.pickImage(source: source, imageQuality: 40);
    final ImagePicker picker = ImagePicker();
    PickedFile? pickedFile =
        await picker.getImage(source: source, imageQuality: 40);
    if (pickedFile != null) {
      File image = File(pickedFile.path);

      final bytes = await image.readAsBytes();
      imageBase.value = base64Encode(bytes);
      imageEmpty.value = false;
    }
  }

  void removeImage() async {
    isLoading(true);
    if (imageBase.value.contains('http')) {
      try {
        // await storeRepo.removeImage(imageBase.value);
      } catch (e) {}
      isLoading(false);
    } else {
      imageBase.value = '';
      imageFile.clear();
      isLoading(false);
    }
  }

  void setServiceType(bool value) {
    isPunch.value = value;
    doItCtrl.text = '';
    getItCtrl.text = '';
  }

  String getInfo() {
    if (isPunch.value) {
      return 'Customers will scan ${doItCtrl.text} times & will receive ${getItCtrl.text} ${nameCtrl.text} / s for free';
    } else {
      return 'For ${nameCtrl.text}, Customers will scan ${doItCtrl.text} times & will receive 1 point per every scan, once they collected total point they\'ll receive ${getItCtrl.text} ${nameCtrl.text} / s for free';
    }
  }

  void pickDate(context, int i) async {
    DateTime selectedDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2023, 1, 1),
      builder: (_, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.yellow,
              primaryColorDark: AppColors.yellow,
            ),
            timePickerTheme: TimePickerTheme.of(context).copyWith(),
          ),
          child: Text(''),
        );
      },
    );
    if (picked != null) {
      selectedDate = picked;
      String time =
          formatDate(selectedDate, [dd, '-', mm, '-', yyyy]).toString();
      if (i == 1) {
        endTime.value = time;
      } else if (i == 2) {
        endTime.value = time;
      }
    }
  }

  void clearFields() {
    nameCtrl.text = '';
    descriptionCtrl.text = '';
    doItCtrl.text = '';
    getItCtrl.text = '';
    priceCtrl.text = '';
    endTime.value = 'Select';
    removeImage();
  }

  Future<void> create() async {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        if (imageBase.value == '') {
          imageEmpty.value = true;
          return;
        }
        if (isPunch.value) {
          if (endTime.value.contains('Select')) {
            errText.value = 'Select expiry Date';
            return;
          }
        }
      }

      errText.value = '';
      final onPos = () async {
        imageEmpty.value = false;
        try {
          final storeM = pageCtrller.storeM.value;
          final serviceM = ServiceM(
              date: setDate(),
              name: nameCtrl.text,
              description: descriptionCtrl.text,
              timings: storeM.timings,
              doIt: toInt(doItCtrl.text),
              getIt: toInt(getItCtrl.text),
              price: toDouble(priceCtrl.text),
              punch: isPunch.value,
              location: setGeoPoint(storeM.location),
              status: storeM.status,
              storeName: storeM.ownerName);
          isLoading(true);
          await servicesRepo.create(serviceM, imageFile);
          isLoading(false);
          JxDialog.dimiss();
          JxSnackBarStatus('Confirmation', 'New Service added');
          clearFields();
        } catch (e) {
          print(e);
          isLoading(false);
          JxSnackBarStatus(null, null);
        }
      };
      JxDialog('Confirmation', getInfo(), 'OK', 'cancel', onPos, null);
    }
  }

  Future<void> updateService(ServiceM serviceM, List<File> images) async {
    try {
      isLoading(true);
      isLoading(false);
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  Future<void> delete(ServiceM serviceM) async {
    try {
      isLoading(true);
      await servicesRepo.delete(serviceM);
      isLoading(false);
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  Stream<QuerySnapshot> get() async* {
    yield* servicesRepo.get();
  }
}
