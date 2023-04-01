import 'package:flutter/cupertino.dart';
import 'package:punchmepartner/clippers/trapezium_clipper.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/size_config.dart';
class HeaderClipped extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TrapeziumClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.18,
        color: AppColors.yellow,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' Punch  ',
                  style: AppStyles.idleTxt.copyWith(
                      backgroundColor: AppColors.black,
                      fontSize: SizeConfig.width * 8)),
              Text(' ME  ',
                  style: AppStyles.idleTxt.copyWith(
                      backgroundColor: AppColors.black,
                      fontSize: SizeConfig.width * 8))
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.1,
        child: Image.asset(
          'assets/images/seamless.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ));
  }
}
