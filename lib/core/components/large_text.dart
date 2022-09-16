import 'package:flutter/material.dart';

class CustomLargeText extends Text {
  final double? size;
  final String? text;
  final Color? color;
  CustomLargeText({this.size = 30, required this.text, this.color, Key? key})
      : super(
          text ?? "",
          key: key,
          style: TextStyle(
              fontSize: size, color: color, fontWeight: FontWeight.bold),
        );
}
