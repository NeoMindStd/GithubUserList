import 'dart:convert';

import 'package:github_user_list/constant/nos.dart' as Nos;
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/repository.dart';

class User {
  int id;
  String login;
  String avatarUrl;
  String htmlUrl;
  String url;
  String followersUrl;
  String followingUrl;
  String starredUrl;
  String reposUrl;

  int followersCount;
  int followingCount;
  int starCount;
  List<Repository> repositories;

  User({
    this.id = Nos.Global.NOT_ASSIGNED_ID,
    this.login = "",
    this.avatarUrl = "",
    this.url = "",
    this.htmlUrl,
    this.followersUrl = "",
    this.reposUrl = "",
  })  : followersCount = 0,
        followingCount = 0,
        starCount = 0,
        repositories = [],
        followingUrl = Strings.HTTP.apiGithubFollowing(login),
        starredUrl = Strings.HTTP.apiGithubStarred(login);

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        login: json['login'] as String ?? "",
        avatarUrl: json['avatar_url'] as String ?? "",
        url: json['url'] as String ?? "",
        htmlUrl: json['html_url'] as String ?? "",
        followersUrl: json['followers_url'] as String ?? "",
        reposUrl: json['repos_url'] as String ?? "",
      );

  factory User.fromJsonString(String string) =>
      User.fromJson(json.decode(string));

  @override
  String toString() => 'User - $login';
}
