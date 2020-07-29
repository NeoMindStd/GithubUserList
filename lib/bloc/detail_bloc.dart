import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:github_user_list/data/repository.dart';
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/util/data_manager.dart';
import 'package:github_user_list/util/dialog.dart';
import 'package:github_user_list/util/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class DetailBloc {
  //////////////////////////////////////////////////
  ///               Fields
  //////////////////////////////////////////////////
  final BuildContext context;
  final User user;

  //////////////////////////////////////////////////
  ///               Controllers
  //////////////////////////////////////////////////
  final _userController = PublishSubject<User>();

  //////////////////////////////////////////////////
  ///               Getters
  //////////////////////////////////////////////////
  get userStream => _userController.stream;

  //////////////////////////////////////////////////
  ///               Methods
  //////////////////////////////////////////////////
  DetailBloc(this.context, this.user);

  getUserDetailInfo() async {
    http.Response followerResponses = await DataManager().httpClient.get(
          user.followersUrl,
        );
    if (followerResponses.statusCode == HttpStatus.ok) {
      user.followers = [];
      for (var followerResponse
          in HttpDecoder.utf8Response(followerResponses)) {
        user.followers.add(User.fromJson(followerResponse));
      }
      _userController.add(user);
    }

    http.Response followingResponses = await DataManager().httpClient.get(
          user.followingUrl,
        );
    if (followingResponses.statusCode == HttpStatus.ok) {
      user.followings = [];
      for (var followingResponse
          in HttpDecoder.utf8Response(followingResponses)) {
        user.followings.add(User.fromJson(followingResponse));
      }
      _userController.add(user);
    }

    http.Response starResponses = await DataManager().httpClient.get(
          user.starredUrl,
        );
    if (starResponses.statusCode == HttpStatus.ok) {
      user.stars = [];
      for (var starResponse in HttpDecoder.utf8Response(starResponses)) {
        user.stars.add(Repository.fromJson(starResponse));
      }
      _userController.add(user);
    }

    http.Response repoResponses = await DataManager().httpClient.get(
          user.reposUrl,
        );
    if (repoResponses.statusCode == HttpStatus.ok) {
      user.repositories = [];
      for (var repoResponse in HttpDecoder.utf8Response(repoResponses)) {
        user.repositories.add(Repository.fromJson(repoResponse));
      }
      _userController.add(user);
    }

    String statusLog = "User id: ${user.id}, account: ${user.login}\n"
        "followerResponses = ${followerResponses.statusCode}\n"
        "followingResponses = ${followingResponses.statusCode}\n"
        "starResponses = ${starResponses.statusCode}\n"
        "repoResponses = ${repoResponses.statusCode}";
    Logger().i(statusLog);

    if (followerResponses.statusCode == HttpStatus.forbidden ||
        followingResponses.statusCode == HttpStatus.forbidden ||
        starResponses.statusCode == HttpStatus.forbidden ||
        repoResponses.statusCode == HttpStatus.forbidden) {
      AppDialog(context).showConfirmDialog(
          "Failed to load some information because API rate limit.");
    } else if (followerResponses.statusCode != HttpStatus.ok ||
        followingResponses.statusCode != HttpStatus.ok ||
        starResponses.statusCode != HttpStatus.ok ||
        repoResponses.statusCode != HttpStatus.ok) {
      String logString = 'followerResponses: ${followerResponses.body}\n'
          'followingResponses: ${followingResponses.body}\n'
          'starResponses: ${starResponses.body}\n'
          'repoResponses: ${repoResponses.body}\n';
      Logger().i(logString);
      AppDialog(context).showConfirmDialog(
          "Failed to load some information because a network communication error occurred.");
    }
  }

  void dispose() {
    _userController.close();
  }
}
