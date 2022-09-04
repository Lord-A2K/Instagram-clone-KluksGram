import 'package:flutter/material.dart';
import 'package:kluksgram/utils/appcolors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors().tertiary,
        width: size.width,
        height: size.height,
        child: Center(
          child: Image(
              image: AssetImage('assets/img/2.png'), height: size.height * .17),
        ),
      ),
    );
  }
}
