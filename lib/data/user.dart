import 'dart:convert';

import 'package:github_user_list/constant/nos.dart' as Nos;
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

  List<User> followers;
  List<User> followings;
  List<Repository> stars;
  List<Repository> repositories;

  User({
    this.id = Nos.Global.NOT_ASSIGNED_ID,
    this.login = "",
    this.avatarUrl = "",
    this.url = "",
    this.htmlUrl,
    this.followersUrl = "",
    this.followingUrl = "",
    this.starredUrl = "",
    this.reposUrl = "",
  })  : followers = [],
        followings = [],
        stars = [],
        repositories = [];

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        login: json['login'] as String ?? "",
        avatarUrl: json['avatar_url'] as String ?? "",
        url: json['url'] as String ?? "",
        htmlUrl: json['html_url'] as String ?? "",
        followersUrl: json['followers_url'] as String ?? "",
        followingUrl: json['following_url'] as String ?? "",
        starredUrl: json['starred_url'] as String ?? "",
        reposUrl: json['repos_url'] as String ?? "",
      );

  factory User.fromJsonString(String string) =>
      User.fromJson(json.decode(string));

  // TODO Remove Stub
  static int dummyCount = 0;
  factory User.createDummyUser() => User.fromJson({
        'login': 'octocat${++dummyCount}',
        'id': dummyCount,
        'avatar_url':
            'https://avatars1.githubusercontent.com/u/583231?s=460&u=a59fef2a493e2b67dd13754231daf220c82ba84d&v=4',
        'url': 'https://api.github.com/users/octocat',
        'html_url': 'https://github.com/octocat',
        'followers_url': 'https://api.github.com/users/octocat/followers',
        'following_url': 'https://api.github.com/users/octocat/following',
        'starred_url': 'https://api.github.com/users/octocat/starred',
        'repos_url': 'https://api.github.com/users/octocat/repos',
      });

  @override
  String toString() => 'User - $login';
}
