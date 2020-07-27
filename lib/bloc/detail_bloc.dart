import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:github_user_list/data/repository.dart';
import 'package:github_user_list/data/user.dart';
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
    http.Response followerResponses = await http.get(
      user.followersUrl,
    );
    if (followerResponses.statusCode == HttpStatus.ok) {
      for (var followerResponse
          in HttpDecoder.utf8Response(followerResponses)) {
        user.followers.add(User.fromJson(followerResponse));
      }
      _userController.add(user);
    }

    http.Response followingResponses = await http.get(
      user.followingUrl,
    );
    if (followingResponses.statusCode == HttpStatus.ok) {
      for (var followingResponse
          in HttpDecoder.utf8Response(followingResponses)) {
        user.followings.add(User.fromJson(followingResponse));
      }
      _userController.add(user);
    }

    http.Response starResponses = await http.get(
      user.starredUrl,
    );
    if (starResponses.statusCode == HttpStatus.ok) {
      for (var starResponse in HttpDecoder.utf8Response(starResponses)) {
        user.stars.add(Repository.fromJson(starResponse));
      }
      _userController.add(user);
    }

    http.Response repoResponses = await http.get(
      user.reposUrl,
    );
    if (repoResponses.statusCode == HttpStatus.ok) {
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
      AppDialog(context).showConfirmDialog("API 사용량 초과로 인해 일부 정보를 불러오지 못했습니다");
    } else if (followerResponses.statusCode != HttpStatus.ok ||
        followingResponses.statusCode != HttpStatus.ok ||
        starResponses.statusCode != HttpStatus.ok ||
        repoResponses.statusCode != HttpStatus.ok) {
      AppDialog(context)
          .showConfirmDialog("네트워크 통신 에러 발생으로 인해 일부 정보를 불러오지 못했습니다");
    }
  }

  void dispose() {
    _userController.close();
  }
}
