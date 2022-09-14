import 'package:flutter/material.dart';

import '../../init/theme/colors.dart';

class CustomSnackBar extends SnackBar {
  final Color? color;
  final String contentText;
  CustomSnackBar({Key? key, required this.contentText, this.color})
      : super(
          key: key,
          content: Text(contentText),
          backgroundColor: color,
          duration: const Duration(seconds: 2),
        );
}
