import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/apis/auth.dart';
import 'package:punchmepartner/models/store_m.dart';
import 'package:punchmepartner/overlays/dialog.dart';
import 'package:punchmepartner/routes/routes.dart';
import 'package:punchmepartner/views/home/pager_ctrller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountCtrller extends GetxController {
  AuthRepo authRepo = AuthApis();
  final formKey = GlobalKey<FormState>();
  final ownerEmailCtrl = TextEditingController();
  final ownerNameCtrl = TextEditingController();
  final ownerPhoneCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final storeMapLinkCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final provinceCtrl = TextEditingController();

  final List<Menu> menus = [
    Menu(name: 'Help & Support', icon: Icons.help_outline),
    Menu(name: 'About', icon: Icons.change_history),
    Menu(name: 'FAQ', icon: Icons.subject_outlined)
  ];

  Future<StoreM> getStoreDetails() async {
    return await authRepo.getStoreDetails();
  }

  void setDetails(StoreM storeM) {
    ownerEmailCtrl.text = storeM.email;
    ownerNameCtrl.text = storeM.ownerName;
    ownerPhoneCtrl.text = storeM.phone;
    nameCtrl.text = storeM.name;
    descriptionCtrl.text = storeM.description;
    addressCtrl.text = storeM.address;
    provinceCtrl.text = storeM.province;
  }

  void logout() async {
    final onPos = () async {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Get.offAllNamed(Routes.login);
    };
    JxDialog('Confirmation', 'You sure you want to logout?', '', 'cancel',
        onPos, null);
  }
}

class Menu {
  Menu({required this.name, required this.icon});
  final String name;
  final IconData icon;
}
