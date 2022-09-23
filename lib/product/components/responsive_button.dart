import 'package:denemefirebaseauth/product/enum/image_enum.dart';
import 'package:flutter/material.dart';

import '../../init/theme/colors.dart';

class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;
  final VoidCallback? onPressed;

  const ResponsiveButton(
      {Key? key, this.isResponsive, this.width, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColor.mainColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsEnum.button.toPng()),
          ],
        ),
      ),
    );
  }
}
