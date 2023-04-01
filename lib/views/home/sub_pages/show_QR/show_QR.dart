import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'show_QR_ctrller.dart';

class ShowQr extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShowQrController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.9),
              borderRadius: AppStyles.minimalBorderRadius),
          child: QrImage(
            data: controller.getOR(),
            version: QrVersions.auto,
            size: 250.0,
          ),
        ),
      ),
    );
  }
}
