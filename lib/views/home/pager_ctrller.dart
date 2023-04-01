import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/apis/auth.dart';
import 'package:punchmepartner/models/store_m.dart';
import 'package:punchmepartner/routes/routes.dart';
import 'package:punchmepartner/views/home/pages/insights/insights.dart';
import 'package:punchmepartner/views/home/pages/requests/requests.dart';
import 'package:punchmepartner/views/home/pages/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/account/account.dart';

class PageCtrller extends GetxController {
  AuthRepo authRepo = AuthApis();

  final currIndex = 0.obs;
  final storeM = StoreM.obs;

  final List<JxPageView> pages = [
    JxPageView(
        page: Requests(),
        icon: Icons.remove_from_queue_sharp,
        name: 'Requests'),
    JxPageView(page: Services(), icon: Icons.room_service, name: 'Offers'),
    JxPageView(page: Insights(), icon: Icons.insights, name: 'Insights'),
    JxPageView(page: Account(), icon: Icons.person, name: 'Account'),
  ];

  @override
  void onInit() {
    super.onInit();
    getStoreDetails();
  }

  void getStoreDetails() async {
    final storeM = await authRepo.getStoreDetails();
    this.storeM.value = storeM;
    final saver = await SharedPreferences.getInstance();
    if (storeM == null) {
      final token = await updateStoreDetails(storeM);
      saver.setString('token', token);
    }
    saver.setString('id', storeM.id);
    saver.setString('email', storeM.email);
    saver.setString('owner_name', storeM.ownerName);
    saver.setString('owner_phone', storeM.phone);
    saver.setString('name', storeM.name);
    saver.setString('description', storeM.description);
    saver.setString('image', storeM.images[0]);
    saver.setString('timings', storeM.timings);
  }

  Future<String> updateStoreDetails(StoreM storeM) async {
    final fbm = FirebaseMessaging.instance;
    String? token = await fbm.getToken();
    final data = {'token': token};
    await authRepo.updateStoreDetails(data);
    return token!;
  }

  bool decideFloatingButtonVisibility() {
    if (currIndex.value == 0 || currIndex.value == 1) {
      return true;
    } else {
      return false;
    }
  }

  IconData decideFloatingButtonIcon() {
    if (currIndex.value == 0) {
      return FontAwesomeIcons.qrcode;
    } else {
      return Icons.add;
    }
  }

  void decideAndGo() {
    if (currIndex.value == 0) {
      Get.toNamed(Routes.showQr);
    } else if (currIndex.value == 1) {
      Get.toNamed(Routes.createService);
    }
  }
}

class JxPageView {
  JxPageView({required this.page, required this.icon, required this.name});
  final Widget page;
  final IconData icon;
  final String name;
}
