import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/home_bloc.dart';
import 'package:github_user_list/screen/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: Provider(
          create: (BuildContext context) => HomeBloc(context),
          child: HomePage(title: '무한 스크롤 화면'),
        ),
      ),
    );
  }
}
