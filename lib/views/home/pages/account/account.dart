import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/common/content_divider.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/common/snapshot_status.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/models/store_m.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/size_config.dart';
import 'account_ctrller.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountCtrller());
    return FutureBuilder<StoreM>(
        future: controller.getStoreDetails(),
        builder: (_, snap) {
          if (snap.hasData) {
            final storeM = snap.data;
            controller.setDetails(storeM!);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: CircleAvatar(
                            radius: SizeConfig.width * 12,
                            backgroundColor: AppColors.black.withOpacity(0.5),
                            child: storeM.images.isEmpty
                                ? Icon(Icons.person,
                                    color: AppColors.yellow.withOpacity(0.8))
                                : Image.network(
                                    storeM.images[0],
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                  )),
                      ),
                      SizedBox(
                        width: SizeConfig.width * 4,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            storeM.name,
                            style: AppStyles.idleTxt.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.width * 5,
                                letterSpacing: 2),
                          ),
                          SizedBox(
                            width: SizeConfig.width,
                          ),
                          Text(
                            storeM.phone,
                            style: AppStyles.idleTxt.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.width * 3.5,
                                letterSpacing: 2),
                          ),
                          Text(
                            storeM.province.capitalize,
                            style: AppStyles.idleTxt.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.width * 3.5,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContentDivider(
                              title: 'Owner Details',
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  enabled: false,
                                  controller: controller.ownerEmailCtrl,
                                  decoration: AppStyles.generalTxtField
                                      .copyWith(labelText: 'Owner\'s email'),
                                  validator: (val) => val.isEmail ? null : '',
                                )),
                                JxSizedBox(),
                                Expanded(
                                    child: TextFormField(
                                  enabled: false,
                                  controller: controller.ownerNameCtrl,
                                  decoration: AppStyles.generalTxtField
                                      .copyWith(labelText: 'Owner\'s name'),
                                  validator: (val) {
                                    if (val == null || val == '') {
                                      return '';
                                    }
                                    return null;
                                  },
                                ))
                              ],
                            ),
                            JxSizedBox(),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  enabled: false,
                                  controller: controller.ownerPhoneCtrl,
                                  decoration: AppStyles.generalTxtField
                                      .copyWith(labelText: 'Owner\'s phone'),
                                  validator: (val) {
                                    if (val == null || val == '') {
                                      return '';
                                    }
                                    return null;
                                  },
                                )),
                                JxSizedBox(),
                                Expanded(child: Container())
                              ],
                            ),
                            JxSizedBox(),
                            ContentDivider(
                              title: 'Store Details',
                            ),
                            TextFormField(
                              enabled: false,
                              controller: controller.nameCtrl,
                              decoration: AppStyles.generalTxtField
                                  .copyWith(labelText: 'Name'),
                              validator: (val) {
                                if (val == null || val == '') {
                                  return '';
                                }
                                return null;
                              },
                            ),
                            JxSizedBox(),
                            TextFormField(
                              enabled: false,
                              controller: controller.descriptionCtrl,
                              maxLines: 3,
                              decoration: AppStyles.generalTxtField.copyWith(
                                  labelText: 'Description',
                                  contentPadding: EdgeInsets.all(15)),
                              validator: (val) {
                                if (val == null || val == '') {
                                  return '';
                                }
                                return null;
                              },
                            ),
                            JxSizedBox(),
                            TextFormField(
                              enabled: false,
                              controller: controller.addressCtrl,
                              maxLines: 3,
                              decoration: AppStyles.generalTxtField.copyWith(
                                  labelText: 'Address',
                                  contentPadding: EdgeInsets.all(15)),
                              validator: (val) {
                                if (val == null || val == '') {
                                  return '';
                                }
                                return null;
                              },
                            ),
                            JxSizedBox(),
                            TextFormField(
                              enabled: false,
                              controller: controller.provinceCtrl,
                              decoration: AppStyles.generalTxtField.copyWith(
                                  labelText: 'Province',
                                  contentPadding: EdgeInsets.all(15)),
                              validator: (val) {
                                if (val == null || val == '') {
                                  return '';
                                }
                                return null;
                              },
                            ),
                            JxSizedBox(),
                            for (int i = 0; i < controller.menus.length; i++)
                              ListTile(
                                onTap: () {},
                                leading: Icon(controller.menus[i].icon),
                                title: JxText(controller.menus[i].name,
                                    size: 4, isBold: true),
                                trailing: Icon(
                                  Icons.navigate_next,
                                  color: AppColors.yellow,
                                ),
                              ),
                            ListTile(
                                onTap: () => controller.logout(),
                                leading: Icon(Icons.exit_to_app_outlined),
                                title:
                                    JxText('Sign out', size: 4, isBold: true)),
                            Divider(
                                thickness: 5,
                                height: 10,
                                color: AppColors.darkGrey.withOpacity(0.5)),
                            ListTile(
                                onTap: null,
                                title: JxText('App Version', size: 4),
                                trailing: JxText('v0.0.1', size: 3)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (snap.hasError) {
            return SnapshotError(
              text: '',
            );
          } else {
            return SnapshotLoading();
          }
        });
  }
}
