import 'package:denemefirebaseauth/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:denemefirebaseauth/screens/onboarding/view/onboarding_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locator.dart';
import 'screens/auth/view/login_view.dart';

bool rememberme = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  rememberme = prefs.getBool('BeniHatirla') ?? false;
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TravelApp',
        home: rememberme ? const OnBoardingView() : const OnBoardingView());
  }
}
