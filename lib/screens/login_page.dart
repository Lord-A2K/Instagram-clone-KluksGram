import 'package:flutter/material.dart';
import 'package:kluksgram/components/loading_dialog.dart';
import 'package:kluksgram/components/text_field_input.dart';
import 'package:kluksgram/resources/auth_method.dart';
import 'package:kluksgram/screens/signup_page.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:kluksgram/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    showLoading(context);
    String res = await AuthMethod().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    Navigator.of(context).pop();
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackbar(res, context);
    }
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors().tertiary,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              // Logo
              Image(image: AssetImage('assets/img/2.png'), height: dh * .15),
              SizedBox(height: 64),
              // Email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 24.0,
              ),
              // Password
              TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter password',
                  textInputType: TextInputType.text,
                  isPass: true),
              SizedBox(
                height: 24.0,
              ),
              // button login
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: Text('Log in',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: AppColors().accent),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
              // signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Don\'t have an account?'),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: Text(
                        ' Sign up.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
