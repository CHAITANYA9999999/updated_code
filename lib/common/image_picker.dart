import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:punchmepartner/common/sizedbox.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/image.dart';
import 'package:punchmepartner/utils/size_config.dart';

import 'buttons.dart';

class JxImagePicker extends StatelessWidget {
  JxImagePicker({
    required this.onSelected,
    required this.onRemoved,
    required this.imageData,
    required this.isEmpty,
  });

  final Function onSelected;
  final Function onRemoved;
  final String imageData;
  final isEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: AppStyles.minimalBorderRadius,
                  child: Container(
                    width: SizeConfig.width * 60,
                    height: SizeConfig.width * 40,
                    decoration: BoxDecoration(
                        color: AppColors.darkerGrey.withOpacity(0.15),
                        borderRadius: AppStyles.minimalBorderRadius,
                        border: Border.all(
                            width: 1.5,
                            color: isEmpty
                                ? AppColors.red
                                : AppColors.darkerGrey.withOpacity(0.15))),
                    child: imageData.contains('http')
                        ?
                        // ? MeetNetworkImage(
                        //     errorBuilder: (_, e) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: JxText('E',
                        //             size: 1.2, color: AppColors.yellow),
                        //       );
                        //     },
                        //     loadingBuilder: (_) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(60),
                        //         child: CircularProgressIndicator(
                        //           strokeWidth: 2,
                        //         ),
                        //       );
                        //     },
                        //     imageUrl: imageData,
                        //     width: SizeConfig.width * 14,
                        //     height: SizeConfig.width * 10,
                        //     fit: BoxFit.cover,
                        //   )
                        Container(
                            child: Image.network(imageData),
                            width: SizeConfig.width * 14,
                            height: SizeConfig.width * 10,
                          )
                        : Image.memory(base64Decode(imageData),
                            width: SizeConfig.width * 14,
                            height: SizeConfig.width * 10,
                            fit: BoxFit.cover),
                  )),
              Visibility(
                  visible: imageData.isEmpty,
                  child: Image.asset(getImage('store.png'),
                      alignment: Alignment.center,
                      width: SizeConfig.width * 10,
                      fit: BoxFit.contain))
            ],
          ),
          JxSizedBox(
            width: 4,
          ),
          Column(
            children: [
              Visibility(
                visible: imageData.isEmpty,
                child: RoundIconBTN(
                  onTap: onSelected,
                  iconData: Icons.attach_file,
                ),
              ),
              JxSizedBox(
                height: 2,
              ),
              Visibility(
                visible: imageData.isNotEmpty,
                child: RoundIconBTN(
                  onTap: onRemoved,
                  iconData: Icons.close,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
