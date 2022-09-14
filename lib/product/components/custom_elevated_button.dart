import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../init/theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        primary: CustomColor.mainColor,
        padding: context.paddingNormal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white)),
    );
  }
}
