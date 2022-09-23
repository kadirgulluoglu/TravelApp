import 'package:denemefirebaseauth/product/enum/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotConnectedNetwork extends StatelessWidget {
  const NotConnectedNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(AssetsEnum.network.toLottie(),
            fit: BoxFit.cover, repeat: true),
      ),
    );
  }
}
