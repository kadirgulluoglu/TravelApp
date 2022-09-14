import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemefirebaseauth/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../init/theme/colors.dart';
import '../../../models/user_model.dart';
import '../../../product/components/custom_elevated_button.dart';
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
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.07,
                  vertical: size.height * 0.14,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        child: FittedBox(
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
                      viewModel.isLoading
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: CircularProgressIndicator(
                                color: CustomColor.mainColor,
                              ),
                            )
                          : buildKayitolbuton(viewModel),
                      buildSignInbuton(viewModel),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAd() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
                return "Ad Boş girilemez";
              }
              if (!regexp.hasMatch(value)) {
                return "Hatalı Ad Soyad";
              }
              return null;
            },
            controller: nameController,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 15),
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
        Text(
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
                return "Mail Boş girilemez";
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return "Hatalı Mail girdiniz";
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
              contentPadding: const EdgeInsets.only(top: 15),
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
        Text(
          'Şifre',
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
                return "Şifre Boş girilemez";
              }
              if (!regexp.hasMatch(value)) {
                return "Hatalı Şifre Girdiniz";
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
                contentPadding: const EdgeInsets.only(top: 15),
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                hintText: "Şifre",
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
        Text(
          'Şifre Tekrar',
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
                return "Şifreler Eşleşmiyor";
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
                contentPadding: const EdgeInsets.only(top: 15),
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                hintText: "Şifre Tekrar",
                hintStyle: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                )),
          ),
        )
      ],
    );
  }

  Widget buildKayitolbuton(AuthViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: CustomElevatedButton(
        onPressed: () {
          signUp(viewModel, emailController.text, passwordController.text);
        },
        title: 'Kayıt Ol',
      ),
    );
  }

  Widget buildSignInbuton(AuthViewModel viewModel) {
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
        text: TextSpan(
          children: [
            TextSpan(
              text: "Hesabınız var mı ? ",
              style: TextStyle(
                  color: CustomColor.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            TextSpan(
                text: "GİRİŞ YAP",
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
            (value) => {
              postDetailsToFirestore(viewModel),
            },
          )
          .catchError((e) {
        Fluttertoast.showToast(
            msg:
                "Daha Önceden Bu E-Posta İle Kayıt Yapılmıştır. Lütfen Farklı Bir E-Posta Adresi Giriniz.");
      });
      viewModel.changeLoading();
    }
  }

  postDetailsToFirestore(AuthViewModel viewModel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    viewModel.changeLoading();
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user?.uid;
    userModel.name = nameController.text;
    userModel.email = user?.email;

    await firebaseFirestore
        .collection("person")
        .doc(user?.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Kayıt Başarılı");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
    viewModel.changeLoading();
  }
}
