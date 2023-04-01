import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/service_tile.dart';
import 'package:punchmepartner/common/snapshot_status.dart';
import 'package:punchmepartner/models/service_m.dart';
import 'package:punchmepartner/res/app_colors.dart';

import 'services_ctrller.dart';

class Services extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServicesController());
    return Column(
      children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: controller.get(),
          builder: (_, snap) {
            if (snap.hasData) {
              if (snap.data!.docs.isEmpty) {
                return SnapshotEmpty('No offers added');
              }
              return ListView.separated(
                  itemCount: snap.data!.docs.length,
                  separatorBuilder: (_, i) {
                    return Container(
                      color: AppColors.lightGrey,
                      padding: EdgeInsets.all(4),
                    );
                  },
                  itemBuilder: (_, i) {
                    final serviceM =
                        ServiceM.fromJson(snap.data!.docs[i].data()! as Map<String, dynamic>);
                    return ServiceTile(serviceM);
                  });
            } else if (snap.hasError) {
              return SnapshotError();
            } else {
              return SnapshotLoading();
            }
          },
        ))
      ],
    );
  }
}
