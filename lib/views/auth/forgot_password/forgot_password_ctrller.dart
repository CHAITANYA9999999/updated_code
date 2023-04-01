import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/apis/auth.dart';
import 'package:punchmepartner/overlays/snackbar.dart';

class ForgotPasswordCtrller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final showProgress = false.obs;
  final AuthRepo authApi = AuthApis();
  final isLoading = false.obs;

  void sendPasswordResetLink() async {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        try {
          isLoading.value = true;
          JxSnackBarLoading(isLoading.value);
          await authApi.sendPasswordResetLink(emailCtrl.text);
          isLoading(false);
          isLoading.value = false;
          JxSnackBarLoading(isLoading.value);

          Future.delayed(Duration(seconds: 2), () {
            Get.back(closeOverlays: true);
          });
          JxSnackBarStatus(
              '', 'Password reset link has to sent to given email');
        } catch (e) {
          isLoading.value = false;
          JxSnackBarLoading(isLoading.value);
          String error;
          if (e.toString() == 'user-not-found') {
            error = 'No user found with that given email';
          } else {
            error = 'Something went wrong...';
          }
          JxSnackBarStatus('', error);
        }
      }
    }
  }
}
