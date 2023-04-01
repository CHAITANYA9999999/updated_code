import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/buttons.dart';
import 'package:punchmepartner/common/header.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/views/auth/login/login_ctrller.dart';

import 'package:punchmepartner/utils/size_config.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrller = Get.put(LoginCtrller());

    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: SafeArea(
          child: Stack(
        children: [
          BackgroundImage(),
          HeaderClipped(),
          Padding(
            padding: EdgeInsets.all(SizeConfig.width * 5),
            child: Form(
              key: ctrller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.height * 20,
                  ),
                  JxText('login',
                      size: 6, color: AppColors.yellow, isBold: true),
                  JxText('For Store Owners',
                      size: 4, color: AppColors.yellow, isBold: true),
                  JxSizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: ctrller.emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            labelText: 'Enter Email',
                            prefixIcon: Icon(Icons.email)),
                        validator: (val) =>
                            val.isEmail ? null : 'Enter valid email address'),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                          controller: ctrller.passwordCtrl,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              labelText: 'Enter Password',
                              prefixIcon: Icon(Icons.lock)),
                          validator: (val) {
                            if (val == null || val.length >= 6) {
                              return 'Password should contain atleast 6 characters';
                            }
                            return null;
                          })),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                        onPressed: () => ctrller.toForgotPassword(),
                        shape: AppStyles.minimalBorder,
                        child: JxText('Forgot password?',
                            size: 4, color: AppColors.yellow)),
                  ),
                  SizedBox(
                    height: SizeConfig.width * 3,
                  ),
                  Row(children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: Obx(
                        () => TextIconBTN(
                          enabled: !ctrller.isLoading.value,
                          onPressed: () => ctrller.login(),
                          label: 'Login',
                          icondata: Icons.navigate_next,
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
