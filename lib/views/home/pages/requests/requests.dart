import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/buttons.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/snapshot_status.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/models/requests_m.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/utils/date_time.dart';
import 'package:punchmepartner/utils/infos.dart';

import 'requests_ctrller.dart';

class Requests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestsController());
    return Column(
      children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: controller.get(),
          builder: (_, snap) {
            if (snap.hasData) {
              if (snap.data!.docs.isEmpty) {
                return SnapshotEmpty('No Request at moment');
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
                    final requestM =
                        RequestM.fromJson(snap.data!.docs[i].data());
                    return RequestTile(requestM);
                  });
            } else if (snap.hasError) {
              return SnapshotError(
                text: '',
              );
            } else {
              return SnapshotLoading();
            }
          },
        ))
      ],
    );
  }
}

class RequestTile extends StatelessWidget {
  RequestTile(this.requestM);
  final RequestM requestM;
  @override
  Widget build(BuildContext context) {
    final RequestsController requestsController = Get.find();
    return Container(
      padding: EdgeInsets.all(5),
      color: AppColors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: JxText(
              getDateFromSTMP(requestM.date),
              size: 3.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: JxText(
              requestM.userName.capitalize,
              size: 4,
              isBold: true,
              color: AppColors.yellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: JxText(
              requestM.serviceName,
              size: 5,
              isBold: true,
              maxLines: 2,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: JxText(
                  getServiceInfo(requestM),
                  size: 4,
                  color: AppColors.yellow,
                ),
              ),
              Spacer(),
              JxMarker(requestM.punch),
            ],
          ),
          Row(
            children: [
              JxSizedBox(
                width: 25,
              ),
              Expanded(
                  child: TextIconBTN(
                onPressed: () =>
                    requestsController.updateRequest(requestM, false),
                enabled: true,
                label: 'Reject',
                icondata: Icons.close,
                outlined: true,
              )),
              JxSizedBox(
                width: 2,
              ),
              Expanded(
                  child: TextIconBTN(
                onPressed: () =>
                    requestsController.updateRequest(requestM, true),
                enabled: true,
                label: 'Accept',
                icondata: Icons.done,
              )),
            ],
          )
        ],
      ),
    );
  }
}

class JxMarker extends StatelessWidget {
  JxMarker(this.isPunch);
  final bool isPunch;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
            color: AppColors.yellow,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
        child: JxText(
          isPunch ? 'Punch' : 'Points',
          size: 3,
          isBold: true,
          color: AppColors.black,
        ),
      ),
    );
  }
}
