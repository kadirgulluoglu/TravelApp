import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  CustomText(
      {Key? key,
      this.size = 16,
      required this.text,
      this.color = Colors.black54})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}