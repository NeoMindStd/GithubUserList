import 'package:flutter/cupertino.dart';
import 'package:github_user_list/util/data_manager.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  //////////////////////////////////////////////////
  ///               Fields
  //////////////////////////////////////////////////
  final BuildContext context;

  bool _obscureText;

  //////////////////////////////////////////////////
  ///               Controllers
  //////////////////////////////////////////////////
  final _obscureTextSubject = PublishSubject<bool>();

  //////////////////////////////////////////////////
  ///               Getters
  //////////////////////////////////////////////////
  bool get isObscureText => _obscureText;
  Stream<bool> get isObscureTextStream => _obscureTextSubject.stream;

  //////////////////////////////////////////////////
  ///               Methods
  //////////////////////////////////////////////////
  AuthBloc(this.context) : _obscureText = true;

  void switchObscureTextMode({bool obscureText}) {
    _obscureText = obscureText ?? !_obscureText;
    _obscureTextSubject.add(_obscureText);
  }

  void login(BuildContext context, {String username, String password}) async {
    await DataManager().login(username: username, password: password);
    Navigator.pop(context);
  }

  void dispose() {
    _obscureTextSubject.close();
  }
}
