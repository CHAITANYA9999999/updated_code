import 'package:get/get.dart';
import 'package:punchmepartner/views/auth/decider/decider.dart';
import 'package:punchmepartner/views/auth/forgot_password/forgot_password.dart';
import 'package:punchmepartner/views/auth/login/login.dart';
import 'package:punchmepartner/views/auth/register/register.dart';
import 'package:punchmepartner/views/home/pager.dart';
import 'package:punchmepartner/views/home/sub_pages/create_service/create_service.dart';
import 'package:punchmepartner/views/home/sub_pages/details_service/details_service.dart';
import 'package:punchmepartner/views/home/sub_pages/show_QR/show_QR.dart';
import 'package:punchmepartner/views/landing/landing.dart';

class Routes {
  static const landing = '/landing';
  static const decider = '/decider';
  static const register = '/register';
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';
  static const phone = '/phone';
  static const otp = '/otp';
  static const pager = '/pager';
  static const createService = '/createService';
  static const detailsService = '/detailsService';
  static const showQr = '/showQr';

  static routes() => [
        GetPage(name: landing, page: () => Landing()),
        GetPage(name: decider, page: () => Decider()),
        GetPage(name: register, page: () => Register()),
        GetPage(name: login, page: () => Login()),
        GetPage(name: forgotPassword, page: () => ForgotPassword()),
        GetPage(name: pager, page: () => Pager()),
        GetPage(name: createService, page: () => CreateService()),
        GetPage(name: detailsService, page: () => DetailsService()),
        GetPage(name: showQr, page: () => ShowQr()),
      ];
}
