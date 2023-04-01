import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/routes/routes.dart';
import 'Res/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Neelkanth());
}

class Neelkanth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData.dark().copyWith(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            accentColor: AppColors.yellow),
        initialRoute: Routes.landing,
        getPages: Routes.routes());
  }
}
