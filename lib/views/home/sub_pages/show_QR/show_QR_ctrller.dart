import 'package:get/get.dart';
import 'package:punchmepartner/views/home/pager_ctrller.dart';

class ShowQrController extends GetxController {
  final PageCtrller pageCtrller = Get.find();

  String getOR() {
    return pageCtrller.storeM.value.id;
  }
}
