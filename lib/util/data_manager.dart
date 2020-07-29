import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/util/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:logger/logger.dart';

class DataManager {
  //////////////////////////////////////////////////
  ///               Fields
  //////////////////////////////////////////////////
  static final DataManager _instance = DataManager._();

  http_auth.BasicAuthClient _basicAuthClient;
  User _loginUser;

  //////////////////////////////////////////////////
  ///               Getters
  //////////////////////////////////////////////////
  User get loginUser => _loginUser;
  bool get isLoggedIn => (_basicAuthClient != null && _loginUser != null);
  http.Client get httpClient => isLoggedIn ? _basicAuthClient : http.Client();

  //////////////////////////////////////////////////
  ///               Methods
  //////////////////////////////////////////////////
  DataManager._();

  factory DataManager() => _instance;

  Future<bool> login(
      {@required String username, @required String password}) async {
    _basicAuthClient = http_auth.BasicAuthClient(username, password);
    http.Response userResponse =
        await _basicAuthClient.get("https://api.github.com/user");
    if (userResponse.statusCode == HttpStatus.ok) {
      _loginUser = User.fromJson(HttpDecoder.utf8Response(userResponse));
      String logString = "Login Success! : $_loginUser";
      Logger().i(logString);
      return true;
    } else {
      String logString = "Login Failed! : ${userResponse.statusCode}\n"
          "${userResponse.body}";
      Logger().i(logString);
      return false;
    }
  }

  logout() {
    _basicAuthClient.close();
    _basicAuthClient = null;
    _loginUser = null;
  }
}
