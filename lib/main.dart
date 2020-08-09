import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/home_bloc.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/screen/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(GithubUserListApp());
}

class GithubUserListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.Global.APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: Provider(
          create: (BuildContext context) => HomeBloc(context: context),
          child: HomePage(title: Strings.HomePage.PAGE_TITLE),
          dispose: (context, HomeBloc _homeBloc) => _homeBloc.dispose(),
        ),
      ),
    );
  }
}
