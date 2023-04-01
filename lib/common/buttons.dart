import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:punchmepartner/common/text.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/size_config.dart';

class TextIconBTN extends StatelessWidget {
  const TextIconBTN({
    required this.onPressed,
    required this.label,
    required this.icondata,
    required this.enabled,
    this.outlined = false,
  });
  final Function onPressed;
  final String label;
  final IconData icondata;
  final bool enabled;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => enabled ? onPressed() : null,
      splashColor:
          outlined ? AppStyles.splashYellow : AppColors.black.withOpacity(0.4),
      shape: AppStyles.minimalBorder.copyWith(
          side: BorderSide(
              width: 1,
              color: outlined ? AppColors.yellow : AppColors.transparent)),
      color: outlined
          ? AppColors.transparent
          : enabled
              ? AppColors.yellow
              : AppColors.yellow.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              JxText(
                label + ' ',
                size: 5,
                isBold: true,
                color: outlined ? AppColors.yellow : AppColors.darkerGrey,
              ),
              Icon(
                icondata,
                color: outlined ? AppColors.yellow : AppColors.black,
                size: SizeConfig.width * 6,
              )
            ]),
      ),
    );
  }
}

class TextBTN extends StatelessWidget {
  const TextBTN({
    required this.onPressed,
    required this.label,
    required this.enabled,
    required this.isDark,
    this.textSize = 5,
    this.hasRadius = false,
  });
  final Function onPressed;
  final String label;
  final bool enabled;
  final bool hasRadius;
  final bool isDark;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius:
              hasRadius ? AppStyles.minimalBorderRadius : BorderRadius.zero),
      onPressed: () => enabled ? onPressed : null,
      splashColor: AppStyles.splashYellow,
      color: enabled
          ? isDark
              ? AppColors.transparent
              : AppColors.yellow
          : AppStyles.splashYellow,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: JxText(
          label,
          size: textSize,
          color: isDark ? AppColors.yellow : AppColors.transparent,
        ),
      ),
    );
  }
}

class RoundedRectBTN extends StatelessWidget {
  RoundedRectBTN({
    required this.onTap,
    required this.label,
    required this.toEnable,
  });
  final Function onTap;
  final String label;
  final bool toEnable;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () => onTap,
        color: toEnable ? AppColors.yellow : AppColors.transparent,
        hoverColor: AppStyles.hoverBlue,
        splashColor: AppStyles.splashYellow,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            side: BorderSide(
              width: 1,
              color: AppColors.yellow,
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: JxText(
            label,
            size: 4,
            isBold: true,
            color: toEnable ? AppColors.darkerGrey : AppColors.white,
          ),
        ));
  }
}

class RoundIconBTN extends StatelessWidget {
  RoundIconBTN({required this.onTap, required this.iconData});
  final Function onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.yellow,
      child: IconButton(
          onPressed: () => onTap, icon: Icon(iconData), color: AppColors.darkerGrey),
    );
  }
}
