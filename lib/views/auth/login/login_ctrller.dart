import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/apis/auth.dart';
import 'package:punchmepartner/overlays/snackbar.dart';
import 'package:punchmepartner/routes/routes.dart';

class LoginCtrller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  AuthRepo authRepo = AuthApis();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailCtrl.text = 'delicacie@admin.com';
    passwordCtrl.text = '1234567890';
  }

  void login() async {
    if (formKey.currentState != null) {
      if(formKey.currentState!.validate()){
        try {
        isLoading.value = true;
        JxSnackBarLoading(isLoading.value);
        await authRepo.login(emailCtrl.text, passwordCtrl.text);
        isLoading.value = false;
        JxSnackBarLoading(isLoading.value);
        Get.offAllNamed(Routes.pager);
      } catch (e) {
        print(e);
        isLoading.value = false;
        JxSnackBarLoading(isLoading.value);
        String error = e.toString();
        // switch (e.code) {
        //   case 'wrong-password':
        //     error = 'Invalid password';
        //     break;
        //   case 'user-not-found':
        //     error = 'Email not found';
        //     break;
        //   default:
        //     error = 'Something went wrong...';
        //     break;
        // }
        JxSnackBarStatus('', error);
      }
      }
      
    }
  }

  void toForgotPassword() => Get.toNamed(Routes.forgotPassword);
}
