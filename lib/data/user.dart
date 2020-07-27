import 'dart:convert';

import 'package:github_user_list/constant/nos.dart' as Nos;

class User {
  int id;
  String login;
  String avatarUrl;

  User({
    this.id = Nos.Global.NOT_ASSIGNED_ID,
    this.login = "",
    this.avatarUrl = "",
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        login: json['login'] as String ?? "",
        avatarUrl: json['avatar_url'] as String ?? "",
      );

  factory User.fromJsonString(String string) =>
      User.fromJson(json.decode(string));

  factory User.createDummyUser() => User.fromJson({
        "login": "octocat",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url":
            "https://avatars2.githubusercontent.com/u/38518273?s=460&v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octocat",
        "html_url": "https://github.com/octocat",
        "followers_url": "https://api.github.com/users/octocat/followers",
        "following_url":
            "https://api.github.com/users/octocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        "starred_url":
            "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        "subscriptions_url":
            "https://api.github.com/users/octocat/subscriptions",
        "organizations_url": "https://api.github.com/users/octocat/orgs",
        "repos_url": "https://api.github.com/users/octocat/repos",
        "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        "received_events_url":
            "https://api.github.com/users/octocat/received_events",
        "type": "User",
        "site_admin": false
      });

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  String toJsonString(User user) => json.encode(user.toJson());

  @override
  String toString() => 'User{id: $id}';
}
