import 'dart:convert';

import 'package:github_user_list/constant/nos.dart' as Nos;
import 'package:github_user_list/data/user.dart';

class Repository {
  int id;
  int stargazersCount;
  int watchersCount;
  int forks;
  int watchers;
  String name;
  String fullName;
  String htmlUrl;
  String description;
  String createdAt;
  String updatedAt;
  String pushedAt;
  String language;
  String license;
  bool isPrivate;
  User owner;

  Repository({
    this.id = Nos.Global.NOT_ASSIGNED_ID,
    this.stargazersCount = 0,
    this.watchersCount = 0,
    this.forks = 0,
    this.watchers = 0,
    this.name = "",
    this.fullName = "",
    this.htmlUrl = "",
    this.description = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.pushedAt = "",
    this.language = "",
    this.license = "",
    this.isPrivate = false,
    this.owner,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        id: json['id'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        stargazersCount: json['stargazers_count'] as int ?? 0,
        watchersCount: json['watchers_count'] as int ?? 0,
        forks: json['forks'] as int ?? 0,
        watchers: json['watchers'] as int ?? 0,
        name: json['name'] as String ?? "",
        fullName: json['full_name'] as String ?? "",
        htmlUrl: json['html_url'] as String ?? "",
        description: json['description'] as String ?? "",
        createdAt: json['created_at'] as String ?? "",
        updatedAt: json['updated_at'] as String ?? "",
        pushedAt: json['pushed_at'] as String ?? "",
        language: json['language'] as String ?? "",
        license:
            (json['license'] as Map ?? {'name': ''})['name'] as String ?? "",
        isPrivate: json['private'] as bool ?? false,
        owner: User.fromJson(json['owner']) ?? null,
      );

  factory Repository.fromJsonString(String string) =>
      Repository.fromJson(json.decode(string));

  @override
  String toString() => 'Repository - $fullName';
}
