import 'package:flutter/material.dart';

import '../../init/theme/colors.dart';

class CustomCircular extends StatelessWidget {
  const CustomCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: CustomColor.mainColor,
      ),
    );
  }
}
