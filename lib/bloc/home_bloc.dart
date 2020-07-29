import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/util/data_manager.dart';
import 'package:github_user_list/util/dialog.dart';
import 'package:github_user_list/util/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mutex/mutex.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  //////////////////////////////////////////////////
  ///               Fields
  //////////////////////////////////////////////////
  final BuildContext context;
  final Mutex usersMutex;
  List<User> users;

  //////////////////////////////////////////////////
  ///               Controllers
  //////////////////////////////////////////////////
  final _usersController = PublishSubject<List<User>>();

  //////////////////////////////////////////////////
  ///               Getters
  //////////////////////////////////////////////////
  get usersStream => _usersController.stream;

  //////////////////////////////////////////////////
  ///               Methods
  //////////////////////////////////////////////////
  HomeBloc(this.context)
      : users = [],
        usersMutex = Mutex();

  onScroll(ScrollController scrollController, double scrollThreshold) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= scrollThreshold) {
      getUserList(users.last.id, 20);
    }
  }

  getUserList(int since, int perPage) async {
    if (usersMutex.isLocked) return;
    usersMutex.acquire();

    try {
      http.Response userResponses = await DataManager().httpClient.get(
            Strings.HTTP.apiGithubUsers(since, perPage),
          );

      String statusLog = "since: $since, perPage: $perPage\n"
          "userResponses = ${userResponses.statusCode}";
      Logger().i(statusLog);

      if (userResponses.statusCode == HttpStatus.forbidden) {
        AppDialog(context).showConfirmDialog(
            "${Strings.HTTP.DIALOG_ERROR_API_RATE_LIMIT_SHORT}: ${userResponses.statusCode}\n\n${HttpDecoder.utf8Response(userResponses)['message']}");
        return;
      } else if (userResponses.statusCode != HttpStatus.ok) {
        String logString = 'userResponses: ${userResponses.body}';
        Logger().i(logString);
        AppDialog(context).showConfirmDialog(
            "${Strings.HTTP.DIALOG_ERROR_NETWORK_SHORT}: ${userResponses.statusCode}");
        return;
      }
      List<User> newUsers = [];
      for (var userResponse in HttpDecoder.utf8Response(userResponses)) {
        newUsers.add(User.fromJson(userResponse));
      }

      users.addAll(newUsers);
      _usersController.add(users);
    } finally {
      usersMutex.release();
    }
  }

  void dispose() {
    users = [];
    _usersController.close();
  }
}
