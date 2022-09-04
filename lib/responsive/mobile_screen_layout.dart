import 'package:flutter/material.dart';
import 'package:kluksgram/components/bottom_navigation.dart';
import 'package:kluksgram/providers/nav_provider.dart';
import 'package:kluksgram/resources/auth_method.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:provider/provider.dart';

import '../utils/global_variable.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    NavProvider _navProvider = Provider.of(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            AnimatedSwitcher(
              switchInCurve: Curves.ease,
              switchOutCurve: Curves.ease,
              duration: const Duration(milliseconds: 200),
              child: screenItems[_navProvider.getNavIndex],
            ),
            //navbar
            AnimatedPositioned(
              bottom: _navProvider.getNavIsShowing ? 0 : -80,
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 500),
              child: AnimatedOpacity(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300),
                opacity: _navProvider.getNavIsShowing ? 1 : 0,
                child: BottomNavigation(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
