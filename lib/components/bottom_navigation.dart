import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:provider/provider.dart';

import '../providers/nav_provider.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  List navItems = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.searchengin,
    FontAwesomeIcons.plus,
    FontAwesomeIcons.bolt,
    FontAwesomeIcons.user
  ];

  @override
  Widget build(BuildContext context) {
    NavProvider _navProvider = Provider.of(context);
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              stops: [0, .6],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      width: size.width,
      height: size.height * .12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          navItems.length,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (() {
              _navProvider.setNavIndex(index);
            }),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  index == 2
                      ? (_navProvider.getNavIndex == index
                          ? BoxShadow(color: AppColors().accent, blurRadius: 50)
                          : BoxShadow(color: Colors.transparent))
                      : BoxShadow(color: Colors.transparent)
                ],
                color: index == 2
                    ? (index == _navProvider.getNavIndex
                        ? AppColors().accent
                        : AppColors().accent.withOpacity(0.3))
                    : Colors.transparent,
              ),
              child: Icon(
                navItems[index],
                shadows: [
                  _navProvider.getNavIndex == index
                      ? Shadow(color: AppColors().accent, blurRadius: 50)
                      : Shadow(color: Colors.transparent)
                ],
                color: _navProvider.getNavIndex == index
                    ? (index == 2 ? Colors.white60 : AppColors().accent)
                    : (index == 2 ? Colors.white38 : AppColors().primary),
                size: index == 2 ? 40 : 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
