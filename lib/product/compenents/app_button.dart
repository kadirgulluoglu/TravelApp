import 'package:flutter/material.dart';

import '../../core/compenents/text.dart';
import '../../init/theme/colors.dart';

class AppButtons extends StatelessWidget {
  final Color? color;
  final String? text;
  final Color? backgroundColor;
  final double? size;
  final Color? borderColor;

  const AppButtons(
      {Key? key,
      this.color,
      this.backgroundColor,
      this.size,
      this.borderColor,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: backgroundColor),
      child: Center(
        child: CustomText(
          color: color!,
          text: text!,
        ),
      ),
    );
  }
}
