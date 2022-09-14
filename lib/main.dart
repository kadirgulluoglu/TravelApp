import 'package:denemefirebaseauth/screens/auth/view/login_view.dart';
import 'package:denemefirebaseauth/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:denemefirebaseauth/screens/home/view/home_view.dart';
import 'package:denemefirebaseauth/screens/home/viewmodel/home_viewmodel.dart';
import 'package:denemefirebaseauth/screens/onboarding/view/onboarding_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locator.dart';

bool rememberme = true;
bool show = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  rememberme = prefs.getBool('RememberMe') ?? false;
  show = prefs.getBool('ON_BOARDING') ?? true;
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
      home: show
          ? const OnBoardingView()
          : rememberme
              ? ChangeNotifierProvider(
                  create: (context) => HomeViewModel(),
                  child: const HomeView(),
                )
              : ChangeNotifierProvider(
                  create: (context) => AuthViewModel(),
                  child: const LoginView(),
                ),
    );
  }
}
