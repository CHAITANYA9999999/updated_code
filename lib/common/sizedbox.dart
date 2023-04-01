import 'package:flutter/material.dart';
import 'package:punchmepartner/utils/size_config.dart';

class JxSizedBox extends StatelessWidget {
  JxSizedBox({this.width = 1, this.height = 1});
  final width;
  final height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.width * width,
      height: SizeConfig.height * height,
    );
  }
}
