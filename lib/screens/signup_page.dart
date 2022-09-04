import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kluksgram/components/loading_dialog.dart';
import 'package:kluksgram/components/text_field_input.dart';
import 'package:kluksgram/resources/auth_method.dart';
import 'package:kluksgram/screens/login_page.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:kluksgram/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _invalidEmail = false;
  bool _usedEmail = false;
  bool _invalidPassword = false;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List? img;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors().primary.withOpacity(.5),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () async {
                      img = await pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                      setState(() {
                        _image = img;
                      });
                    },
                    child: const Text(
                      'Gallery',
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    )),
                TextButton(
                    onPressed: () async {
                      img = await pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                      setState(() {
                        _image = img;
                      });
                    },
                    child: const Text(
                      'camera',
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  void signupUser() async {
    if (_image == null) {
      showSnackbar('No profile picture !', context);
      return;
    }
    showLoading(context);
    String res = await AuthMethod().signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
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
      if (res ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        setState(() {
          _invalidEmail = true;
        });
      } else {
        setState(() {
          _invalidEmail = false;
        });
      }

      if (res ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        setState(() {
          _usedEmail = true;
        });
      } else {
        setState(() {
          _usedEmail = false;
        });
      }

      if (res ==
          '[firebase_auth/weak-password] Password should be at least 6 characters') {
        setState(() {
          _invalidPassword = true;
        });
      } else {
        setState(() {
          _invalidPassword = false;
        });
      }
    }
    print(res);
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors().tertiary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image(image: AssetImage('assets/img/2.png'), height: dh * .15),
                SizedBox(height: 20),
                // profile
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/474x/8f/1b/09/8f1b09269d8df868039a5f9db169a772.jpg'),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                // username
                TextFieldInput(
                    textEditingController: _usernameController,
                    hintText: 'Enter your username',
                    textInputType: TextInputType.text),

                //invalid email
                _invalidEmail
                    ? Container(
                        width: double.infinity,
                        height: 24,
                        child: Text(
                          '*invalid email',
                          style: TextStyle(
                              color: AppColors().accent,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : _usedEmail
                        ? Container(
                            width: double.infinity,
                            height: 24,
                            child: Text(
                              '*The email address is already in use by another account.',
                              style: TextStyle(
                                  color: AppColors().accent,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : SizedBox(height: 24.0),

                // Email
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress),
                _invalidPassword
                    ? Container(
                        width: double.infinity,
                        height: 24,
                        child: Text(
                          '*Password should be at least 6 characters',
                          style: TextStyle(
                              color: AppColors().accent,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(
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
                // Email
                TextFieldInput(
                  textEditingController: _bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                  multiline: true,
                ),
                SizedBox(height: 24.0),
                // button login
                Material(
                  child: InkWell(
                    onTap: signupUser,
                    child: Container(
                      child: Text('Sign up',
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
                ),
                const SizedBox(height: 24),
                // Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text('All-ready have an account?'),
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: Text(
                          ' Login.',
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
      ),
    );
  }
}
