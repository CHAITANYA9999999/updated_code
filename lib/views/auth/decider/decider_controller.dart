import 'package:get/get.dart';
import 'package:punchmepartner/routes/routes.dart';

class DeciderController extends GetxController {

  void toRegister() => Get.toNamed(Routes.register);
  
  void toLogin() => Get.toNamed(Routes.login);
}
