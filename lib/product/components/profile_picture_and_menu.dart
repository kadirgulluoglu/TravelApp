import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class ProfilePictureAndMenuIcon extends StatelessWidget {
  const ProfilePictureAndMenuIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingProfile,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, size: 30, color: Colors.black54),
          Expanded(child: Container()),
          Container(
            margin: context.paddingRight,
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(10), // Image radius
                child: Image.network(
                    'https://doodleipsum.com/700/avatar-3?i=5ff278e220eacb10b8e37efefef406a6',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
