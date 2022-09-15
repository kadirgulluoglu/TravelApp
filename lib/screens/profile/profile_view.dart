import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemefirebaseauth/core/components/large_text.dart';
import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/components/text.dart';
import '../../models/user_model.dart';
import '../../product/components/profile_widget.dart';
import '../auth/view/login_view.dart';
import '../auth/viewmodel/auth_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel = UserModel();
  @override
  void initState() {
    super.initState();
    getFirebase();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: context.paddingNormal,
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: context.paddingNormal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [Icon(Icons.notifications)]),
              ),
              Container(
                margin: context.paddingRight,
                width: 200,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(200), // Image radius
                    child: Image.network('https://picsum.photos/200',
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomLargeText(text: userModel!.name.toString()),
              CustomText(text: userModel!.email.toString()),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfileWidget(
                      icon: Icons.settings,
                      title: 'Ayarlar',
                    ),
                    const ProfileWidget(
                      icon: Icons.notifications,
                      title: 'Bildirimler',
                    ),
                    const ProfileWidget(
                      icon: Icons.chat,
                      title: 'S.S.S',
                    ),
                    const ProfileWidget(
                      icon: Icons.share,
                      title: 'Paylaş',
                    ),
                    ProfileWidget(
                      onPressed: () => logout(context),
                      icon: Icons.logout,
                      title: 'Çıkış Yap',
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('RememberMe', false);
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
        child: const LoginView(),
      ),
    ));
  }

  Future getFirebase() async {
    await FirebaseFirestore.instance
        .collection("person")
        .doc(user!.uid)
        .get()
        .then((value) => {
              userModel = UserModel.fromMap(value.data()),
              setState(() {}),
            });
  }
}
