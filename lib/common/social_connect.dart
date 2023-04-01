import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/utils/size_config.dart';

class SocialConnect extends StatelessWidget {
  const SocialConnect({
    required this.onGoogleTap,
    required this.onFacebookTap,
  });

  final Function onGoogleTap;
  final Function onFacebookTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(
            backgroundColor: AppColors.yellow,
            radius: SizeConfig.width * 5,
            child: IconButton(
              color: AppColors.yellow,
              onPressed: () => onGoogleTap(),
              icon: Icon(FontAwesomeIcons.google,
                  size: SizeConfig.width * 4, color: AppColors.black),
            )),
        SizedBox(
          height: SizeConfig.height * 5,
          child: VerticalDivider(
            color: AppColors.white,
            thickness: 1,
            width: SizeConfig.height * 8,
          ),
        ),
        CircleAvatar(
            backgroundColor: AppColors.yellow,
            radius: SizeConfig.width * 5,
            child: IconButton(
              color: AppColors.yellow,
              onPressed: () => onFacebookTap(),
              icon: Icon(FontAwesomeIcons.facebookF,
                  size: SizeConfig.width * 4, color: AppColors.black),
            ))
      ]),
    );
  }
}
