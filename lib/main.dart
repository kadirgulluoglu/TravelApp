import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/screen/home/view/home_view.dart';
import 'package:travelapp/screen/home/viewmodel/home_viewmodel.dart';
import 'package:travelapp/screen/onboarding/view/onboarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      home: ChangeNotifierProvider(
        create: (context) => HomeViewModel(),
        child: HomeView(),
      ),
    );
  }
}
