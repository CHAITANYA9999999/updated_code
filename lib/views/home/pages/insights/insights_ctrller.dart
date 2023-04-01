import 'package:get/get.dart';
import 'package:punchmepartner/apis/insights.dart';
import 'package:punchmepartner/models/store_m.dart';
import 'package:punchmepartner/models/user_m.dart';
import 'package:punchmepartner/views/home/pager_ctrller.dart';

class InsightsController extends GetxController {
  InsightsRepo insightsRepo = InsightsApis();
  final PageCtrller pageCtrller = Get.find();

  Future<List<UserM>> getUsers() async {
    List<UserM> users = [];
    final usersId = pageCtrller.storeM.value.users;
    for (String id in usersId) {
      final userDetails = await insightsRepo.getUsers(id);
      users.add(userDetails);
    }
    return users;
  }
}
