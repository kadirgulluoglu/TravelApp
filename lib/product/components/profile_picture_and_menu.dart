import 'package:flutter/material.dart';

class ProfilePictureAndMenuIcon extends StatelessWidget {
  const ProfilePictureAndMenuIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, size: 30, color: Colors.black54),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(10), // Image radius
                child: Image.network('https://picsum.photos/200',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
