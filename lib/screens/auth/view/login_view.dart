import 'package:denemefirebaseauth/product/compenents/custom_elevated_button.dart';
import 'package:denemefirebaseauth/screens/auth/view/register_view.dart';
import 'package:denemefirebaseauth/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:denemefirebaseauth/screens/home/view/home_view.dart';
import 'package:denemefirebaseauth/screens/home/viewmodel/home_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../init/theme/colors.dart';
import 'forgot_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //key
  late final GlobalKey<FormState> _formKey;

  //editingController
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                          'Giriş Yap',
                          style: TextStyle(
                              color: CustomColor.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.10),
                    buildEposta(),
                    SizedBox(height: size.height * 0.02),
                    buildPassword(viewModel),
                    _buildForgotPassword(),
                    buildRememberMe(viewModel),
                    SizedBox(height: size.height * 0.02),
                    viewModel.isLoading
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: CircularProgressIndicator(
                              color: CustomColor.mainColor,
                            ),
                          )
                        : buildLoginButton(viewModel),
                    buildSignupButton(viewModel),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
                  color: Colors.white,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Boş Mail girdiniz";
              }
              if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                  .hasMatch(value)) {
                return "Hatalı Mail girdiniz";
              }
              return null;
            },
            onSaved: (value) {
              _emailController.text = value!;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Theme.of(context).disabledColor,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 15),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: "E-Posta",
                hintStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ),
        )
      ],
    );
  }

  Widget buildPassword(AuthViewModel viewModel) {
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
                  color: Colors.white,
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
                return "Hatalı şifre girdiniz";
              }
              return null;
            },
            onSaved: (value) {
              _passwordController.text = value!;
            },
            autofocus: false,
            controller: _passwordController,
            obscureText: viewModel.isObscure,
            textInputAction: TextInputAction.done,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15),
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  onPressed: () => viewModel.changeObscure(),
                  icon: Icon(
                    viewModel.isObscure
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                ),
                hintText: "Şifre",
                hintStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ),
        )
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.only(right: 0)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForgotPassword()),
          );
        },
        child: Text(
          'Şifremi Unuttum',
          style: TextStyle(
            color: CustomColor.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildRememberMe(AuthViewModel viewModel) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: CustomColor.mainColor,
            ),
            child: Checkbox(
              value: viewModel.rememberMe,
              checkColor: Colors.white,
              activeColor: CustomColor.mainColor,
              onChanged: (value) {
                viewModel.rememberMe = value!;
              },
            ),
          ),
          Text(
            'Beni Hatırla',
            style: TextStyle(
              color: CustomColor.mainColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginButton(AuthViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: CustomElevatedButton(
        onPressed: () {
          login(viewModel, _emailController.text, _passwordController.text);
        },
        title: 'Giriş',
      ),
    );
  }

  Widget buildSignupButton(AuthViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<AuthViewModel>.value(
            value: viewModel,
            child: const RegisterView(),
          ),
        ));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Hesabınız yok mu ? ",
              style: TextStyle(
                  color: CustomColor.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            TextSpan(
                text: "KAYIT OL",
                style: TextStyle(
                  color: CustomColor.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  void login(AuthViewModel viewModel, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      viewModel.changeLoading();
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Giriş Başarılı"),
                saveSharedPreferences(viewModel),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => HomeViewModel(),
                      child: const HomeView(),
                    ),
                  ),
                ),
              })
          .catchError((e) {
        viewModel.changeLoading();
        Fluttertoast.showToast(msg: "Giriş Başarısız");
      });
    }
  }

  Future saveSharedPreferences(AuthViewModel viewModel) async {
    final prefs = await SharedPreferences.getInstance();
    if (viewModel.rememberMe) {
      await prefs.setBool('BeniHatirla', true);
    } else {
      await prefs.setBool('BeniHatirla', false);
    }
  }
}
