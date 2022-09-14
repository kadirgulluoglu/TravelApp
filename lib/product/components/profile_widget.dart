import 'package:denemefirebaseauth/core/components/text.dart';
import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
  final Color? color;
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: context.paddingNormalVertical,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color ?? Colors.black.withOpacity(.5),
                  size: 24,
                ),
                const SizedBox(width: 16),
                CustomText(text: title, color: color ?? Colors.black54),
              ],
            ),
            color != null
                ? const SizedBox.shrink()
                : Icon(Icons.arrow_forward_ios,
                    color: Colors.black.withOpacity(.4), size: 16),
          ],
        ),
      ),
    );
  }
}
