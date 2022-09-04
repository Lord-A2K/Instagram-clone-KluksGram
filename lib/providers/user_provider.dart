import 'package:flutter/material.dart';
import 'package:kluksgram/models/user.dart';
import 'package:kluksgram/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  User get getUser => _user;
  final AuthMethod _authMethod = AuthMethod();

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
