import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/repository.dart';
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/util/data_manager.dart';
import 'package:github_user_list/util/dialog.dart';
import 'package:github_user_list/util/http_decoder.dart';
import 'package:github_user_list/util/reference_wrapper.dart';
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
  DetailBloc(this.user, {this.context});

  getUserDetailInfo() async {
    ReferenceWrapper<http.Response> followerResponses = ReferenceWrapper();
    ReferenceWrapper<http.Response> followingResponses = ReferenceWrapper();
    ReferenceWrapper<http.Response> starResponses = ReferenceWrapper();
    ReferenceWrapper<http.Response> repoResponses = ReferenceWrapper();

    List<Future> futures = [
      getFollowerCount(followerResponses),
      getFollowingCount(followingResponses),
      getStarCount(starResponses),
      getRepositories(repoResponses),
    ];

    Stream.fromFutures(futures).listen((_) {}, onDone: () {
      String statusLog = "User id: ${user.id}, account: ${user.login}\n"
          "followerResponses = ${followerResponses.obj.statusCode}\n"
          "followingResponses = ${followingResponses.obj.statusCode}\n"
          "starResponses = ${starResponses.obj.statusCode}\n"
          "repoResponses = ${repoResponses.obj.statusCode}";
      Logger().i(statusLog);

      if (followerResponses.obj.statusCode == HttpStatus.forbidden ||
          followingResponses.obj.statusCode == HttpStatus.forbidden ||
          starResponses.obj.statusCode == HttpStatus.forbidden ||
          repoResponses.obj.statusCode == HttpStatus.forbidden) {
        if (context != null) {
          AppDialog(context)
              .showConfirmDialog(Strings.HTTP.DIALOG_ERROR_API_RATE_LIMIT_LONG);
        }
      } else if (followerResponses.obj.statusCode != HttpStatus.ok ||
          followingResponses.obj.statusCode != HttpStatus.ok ||
          starResponses.obj.statusCode != HttpStatus.ok ||
          repoResponses.obj.statusCode != HttpStatus.ok) {
        String logString = 'followerResponses: ${followerResponses.obj.body}\n'
            'followingResponses: ${followingResponses.obj.body}\n'
            'starResponses: ${starResponses.obj.body}\n'
            'repoResponses: ${repoResponses.obj.body}\n';
        Logger().i(logString);
        if (context != null) {
          AppDialog(context)
              .showConfirmDialog(Strings.HTTP.DIALOG_ERROR_NETWORK_LONG);
        }
      }
    });
  }

  Future<void> getFollowerCount(
      ReferenceWrapper<http.Response> followerResponses) async {
    followerResponses.obj = await DataManager().httpClient.get(
          user.followersUrl,
        );
    if (followerResponses.obj.statusCode == HttpStatus.ok) {
      user.followersCount =
          HttpDecoder.utf8Response(followerResponses.obj).length;
      _userController.add(user);
    }
  }

  Future<void> getFollowingCount(
      ReferenceWrapper<http.Response> followingResponses) async {
    followingResponses.obj = await DataManager().httpClient.get(
          user.followingUrl,
        );
    if (followingResponses.obj.statusCode == HttpStatus.ok) {
      user.followingCount =
          HttpDecoder.utf8Response(followingResponses.obj).length;
      _userController.add(user);
    }
  }

  Future<void> getStarCount(
      ReferenceWrapper<http.Response> starResponses) async {
    starResponses.obj = await DataManager().httpClient.get(
          user.starredUrl,
        );
    if (starResponses.obj.statusCode == HttpStatus.ok) {
      user.starCount = HttpDecoder.utf8Response(starResponses.obj).length;
      _userController.add(user);
    }
  }

  Future<void> getRepositories(
      ReferenceWrapper<http.Response> repoResponses) async {
    repoResponses.obj = await DataManager().httpClient.get(
          user.reposUrl,
        );
    if (repoResponses.obj.statusCode == HttpStatus.ok) {
      user.repositories = [];
      for (var repoResponse in HttpDecoder.utf8Response(repoResponses.obj)) {
        user.repositories.add(Repository.fromJson(repoResponse));
        _userController.add(user);
      }
    }
  }

  void dispose() {
    _userController.close();
  }
}
