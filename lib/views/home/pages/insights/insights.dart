import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/snapshot_status.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/models/user_m.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/size_config.dart';
import 'insights_ctrller.dart';

class Insights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InsightsController());
    return Column(
      children: [
        JxSizedBox(
          height: 30,
        ),
        Container(
          width: double.infinity,
          color: AppColors.black.withOpacity(0.5),
          padding: EdgeInsets.all(15),
          child: JxText(
            'Customers',
            color: AppColors.yellow,
          ),
        ),
        Expanded(
          child: FutureBuilder<List<UserM>>(
              future: controller.getUsers(),
              builder: (_, snap) {
                if (snap.hasData) {
                  if (snap.data!.isEmpty) {
                    return SnapshotEmpty('No customers found');
                  }
                  return ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (_, i) {
                        final user = snap.data![i];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                child: CircleAvatar(
                                    radius: SizeConfig.width * 8,
                                    backgroundColor:
                                        AppColors.black.withOpacity(0.5),
                                    child: user.image == null
                                        ? Icon(Icons.person,
                                            color: AppColors.yellow
                                                .withOpacity(0.8))
                                        : Image.network(user.image)),
                              ),
                              SizedBox(
                                width: SizeConfig.width * 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: AppStyles.idleTxt.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.width * 5,
                                        letterSpacing: 2),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.width,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Visibility(
                                visible: false,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    size: SizeConfig.width * 8,
                                    color: AppColors.yellow,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
                if (snap.hasError) {
                  print(snap.error);
                  return SnapshotError(
                    text: '',
                  );
                } else {
                  return SnapshotLoading();
                }
              }),
        )
      ],
    );
  }
}
