import 'package:flutter/material.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/util/data_manager.dart';
import 'package:github_user_list/util/dialog.dart';
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
    if (await DataManager().login(username: username, password: password)) {
      Navigator.pop(context);
    } else {
      AppDialog(context)
          .showConfirmDialog(Strings.AuthPage.DIALOG_LOGIN_FAILED);
    }
  }

  void dispose() {
    _obscureTextSubject.close();
  }
}
