import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/size_config.dart';
import 'package:punchmepartner/views/home/pager_ctrller.dart';

class Pager extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final pageController = Get.put(PageCtrller());
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: SafeArea(
          child: Obx(
        () => IndexedStack(
          index: pageController.currIndex.value,
          children: [for (JxPageView view in pageController.pages) view.page],
        ),
      )),
      floatingActionButton: Obx(
        () => Visibility(
          visible: pageController.decideFloatingButtonVisibility(),
          child: FloatingActionButton(
            onPressed: () => pageController.decideAndGo(),
            backgroundColor: AppColors.yellow,
            child: Icon(pageController.decideFloatingButtonIcon(),
                color: AppColors.black),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: SizeConfig.height * 9,
        color: Colors.black,
        child: Row(
          children: [
            for (int i = 0; i < pageController.pages.length; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () => pageController.currIndex.value = i,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Icon(pageController.pages[i].icon,
                            size: i == pageController.currIndex.value
                                ? SizeConfig.width * 8
                                : SizeConfig.width * 6.5,
                            color: i == pageController.currIndex.value
                                ? AppColors.yellow
                                : AppColors.white),
                      ),
                      Obx(
                        () => Text(pageController.pages[i].name,
                            style: AppStyles.idleTxt.copyWith(
                                color: i == pageController.currIndex.value
                                    ? AppColors.yellow
                                    : AppColors.white,
                                fontSize: SizeConfig.width * 3.5)),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
