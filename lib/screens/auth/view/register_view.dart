import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:denemefirebaseauth/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../init/theme/colors.dart';
import '../../../models/user_model.dart';
import '../../../product/components/custom_elevated_button.dart';
import '../../../product/components/custom_snackbar.dart';
import '../../home/view/home_view.dart';
import '../../home/viewmodel/home_viewmodel.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final FirebaseAuth _auth;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordAgainController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: context.paddingCustomHorizontalAndVertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        child: const FittedBox(
                          child: Text(
                            'KAYIT OL',
                            style: TextStyle(
                                color: CustomColor.mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      buildAd(),
                      SizedBox(height: size.height * 0.02),
                      buildEposta(),
                      SizedBox(height: size.height * 0.02),
                      buildSifre(viewModel),
                      SizedBox(height: size.height * 0.02),
                      buildYeniSifre(viewModel),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const SizedBox(height: 20),
                      buildRegisterButton(viewModel),
                      buildLoginButton(viewModel),
                    ],
                  ),
                ),
              ),
            ),
            viewModel.isLoading
                ? Container(
                    color: Colors.black.withOpacity(0.3),
                    width: context.width,
                    height: context.height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: CustomColor.mainColor,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget buildAd() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ad Soyad',
          style: TextStyle(
            color: CustomColor.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: CustomColor.mainColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              RegExp regexp = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return "Ad Bo?? girilemez";
              }
              if (!regexp.hasMatch(value)) {
                return "Hatal?? Ad Soyad";
              }
              return null;
            },
            controller: nameController,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: context.paddingNormalTop,
                prefixIcon:
                    const Icon(Icons.account_circle, color: Colors.white),
                hintText: "Ad Soyad",
                hintStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ),
        )
      ],
    );
  }

  Widget buildEposta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'E-Posta',
          style: TextStyle(
            color: CustomColor.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: CustomColor.mainColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Mail Bo?? girilemez";
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return "Hatal?? Mail girdiniz";
              }
              return null;
            },
            onSaved: (value) {
              emailController.text = value!;
            },
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: context.paddingNormalTop,
              prefixIcon: const Icon(Icons.email, color: Colors.white),
              hintText: "Eposta",
              hintStyle:
                  TextStyle(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        )
      ],
    );
  }

  Widget buildSifre(AuthViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '??ifre',
          style: TextStyle(
            color: CustomColor.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: CustomColor.mainColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              RegExp regexp = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return "??ifre Bo?? girilemez";
              }
              if (!regexp.hasMatch(value)) {
                return "Hatal?? ??ifre Girdiniz";
              }
              return null;
            },
            onSaved: (value) {
              passwordController.text = value!;
            },
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: viewModel.isObscure,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: context.paddingNormalTop,
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                hintText: "??ifre",
                hintStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ),
        )
      ],
    );
  }

  Widget buildYeniSifre(AuthViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '??ifre Tekrar',
          style: TextStyle(
            color: CustomColor.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: CustomColor.mainColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (passwordController.text != passwordAgainController.text) {
                return "??ifreler E??le??miyor";
              }
              return null;
            },
            onSaved: (value) {
              passwordAgainController.text = value!;
            },
            controller: passwordAgainController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: viewModel.isObscure,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: context.paddingNormalTop,
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                hintText: "??ifre Tekrar",
                hintStyle: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                )),
          ),
        )
      ],
    );
  }

  Widget buildRegisterButton(AuthViewModel viewModel) {
    return Container(
      padding: context.paddingNormalVertical,
      width: double.infinity,
      child: CustomElevatedButton(
        onPressed: () {
          signUp(viewModel, emailController.text, passwordController.text);
        },
        title: 'Kay??t Ol',
      ),
    );
  }

  Widget buildLoginButton(AuthViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => AuthViewModel(),
            child: const LoginView(),
          ),
        ));
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Hesab??n??z var m?? ? ",
              style: TextStyle(
                  color: CustomColor.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            TextSpan(
                text: "G??R???? YAP",
                style: TextStyle(
                  fontSize: 18,
                  color: CustomColor.mainColor,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  void signUp(AuthViewModel viewModel, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      viewModel.changeLoading();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) async => {
              postDetailsToFirestore(viewModel),
              await _auth
                  .signInWithEmailAndPassword(email: email, password: password)
                  .then((uid) => {
                        savedShared(),
                      })
                  .catchError((e) {
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                  contentText: "Giri?? Ba??ar??s??z!!",
                  color: CustomColor.mainColor,
                ));
              }),
            },
          )
          .catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            contentText: "Mail kullan??lm???? isterseniz giri?? yap??n",
            color: CustomColor.mainColor,
          ),
        );
        viewModel.changeLoading();
      });
    }
  }

  postDetailsToFirestore(AuthViewModel viewModel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user?.uid;
    userModel.name = nameController.text;
    userModel.email = user?.email;
    await firebaseFirestore
        .collection("person")
        .doc(user?.uid)
        .set(userModel.toMap());
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
      contentText: "Kay??t Ba??ar??l??",
      color: CustomColor.mainColor,
    ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
          child: const HomeView(),
        ),
      ),
    );
  }
}

Future<void> savedShared() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('RememberMe', true);
}
