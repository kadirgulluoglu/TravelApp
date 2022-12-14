import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:denemefirebaseauth/screens/auth/view/register_view.dart';
import 'package:denemefirebaseauth/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:denemefirebaseauth/screens/home/view/home_view.dart';
import 'package:denemefirebaseauth/screens/home/viewmodel/home_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../init/theme/colors.dart';
import '../../../product/components/custom_elevated_button.dart';
import '../../../product/components/custom_snackbar.dart';
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
                          'Giri?? Yap',
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
                    buildLoginButton(viewModel),
                    buildSignupButton(viewModel),
                  ],
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
                  color: Colors.white,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Bo?? Mail girdiniz";
              }
              if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                  .hasMatch(value)) {
                return "Hatal?? Mail girdiniz";
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
                contentPadding: context.paddingNormalTop,
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
                return "??ifre Bo?? girilemez";
              }
              if (!regexp.hasMatch(value)) {
                return "Hatal?? ??ifre girdiniz";
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
                contentPadding: context.paddingNormalTop,
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
                hintText: "??ifre",
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForgotPassword()),
          );
        },
        child: const Text(
          '??ifremi Unuttum',
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
          const Text(
            'Beni Hat??rla',
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
      padding: context.paddingNormalVertical,
      width: double.infinity,
      child: CustomElevatedButton(
        onPressed: () {
          login(viewModel, _emailController.text, _passwordController.text);
        },
        title: 'Giri??',
      ),
    );
  }

  Widget buildSignupButton(AuthViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => AuthViewModel(),
              child: const RegisterView(),
            ),
          ),
        );
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Hesab??n??z yok mu ? ",
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
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(
                    contentText: "Giri?? Ba??ar??l??!!",
                    color: CustomColor.mainColor,
                  ),
                ),
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
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          contentText: "Giri?? Ba??ar??s??z!!",
          color: CustomColor.mainColor,
        ));
      });
    }
  }

  Future saveSharedPreferences(AuthViewModel viewModel) async {
    final prefs = await SharedPreferences.getInstance();
    if (viewModel.rememberMe) {
      await prefs.setBool('RememberMe', true);
    } else {
      await prefs.setBool('RememberMe', false);
    }
  }
}
