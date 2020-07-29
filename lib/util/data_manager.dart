import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/util/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class DataManager {
  //////////////////////////////////////////////////
  ///               Fields
  //////////////////////////////////////////////////
  static final DataManager _instance = DataManager._();

  User _loginUser;
  OAuth2Client _oAuth2Client;
  OAuth2Helper _oAuth2Helper;

  //////////////////////////////////////////////////
  ///               Getters
  //////////////////////////////////////////////////
  User get loginUser => _loginUser;
  bool get isLoggedIn =>
      (_oAuth2Client != null && _oAuth2Helper != null && _loginUser != null);
  get httpClient => isLoggedIn ? _oAuth2Helper : http.Client();

  //////////////////////////////////////////////////
  ///               Methods
  //////////////////////////////////////////////////
  DataManager._();

  factory DataManager() => _instance;

  Future<bool> login() async {
    String clientId = "";
    String clientSecret = "";
    try {
      Map oauthInfo = await rootBundle.loadStructuredData(
          Strings.Global.ASSETS_GITHUB_OAUTH, (String jsonString) async {
        return jsonDecode(jsonString);
      });
      clientId = oauthInfo['client_id'];
      clientSecret = oauthInfo['client_secret'];
    } catch (e) {
      print("Couldn't read secret file: $e");
    }

    _oAuth2Client = GitHubOAuth2Client(
      customUriScheme: 'my.app',
      redirectUri: 'my.app://oauth2redirect',
    );
    _oAuth2Helper = OAuth2Helper(
      _oAuth2Client,
      grantType: OAuth2Helper.AUTHORIZATION_CODE,
      clientId: clientId,
      clientSecret: clientSecret,
      scopes: ['repo', 'user'],
    );

    http.Response userResponse =
        await _oAuth2Helper.get(Strings.HTTP.API_GITHUB_LOGGED_IN_USER);
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

  logout() async {
    _oAuth2Client.revokeToken(await _oAuth2Helper.getToken());
    _oAuth2Helper.disconnect();
    _oAuth2Helper = null;
    _oAuth2Client = null;
    _loginUser = null;
  }
}
