import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  int _navIndex = 0;
  int get getNavIndex => _navIndex;
  bool _navIsShowing = true;
  bool get getNavIsShowing => _navIsShowing;

  setNavIsShowing(bool a) {
    _navIsShowing = a;
    notifyListeners();
  }

  setNavIndex(int i) {
    _navIndex = i;
    notifyListeners();
  }

  showTheBottomSheet(context, Widget child) {
    var bottomSheetController = showBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 10,
        context: context,
        builder: (context) => child);
    setNavIsShowing(false);

    bottomSheetController.closed.then((value) => setNavIsShowing(true));
  }
}
