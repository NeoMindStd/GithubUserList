import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/auth_bloc.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/bloc/home_bloc.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/screen/auth_page.dart';
import 'package:github_user_list/screen/detail_page.dart';
import 'package:github_user_list/screen/widget/home/user_list.dart';
import 'package:github_user_list/util/data_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title = "HomePage"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBloc = Provider.of<HomeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DataManager().isLoggedIn
                    ? Provider(
                        create: (BuildContext context) =>
                            DetailBloc(context, DataManager().loginUser),
                        child: DetailPage(
                          title: Strings.DetailPage.PAGE_TITLE_LOGGED_IN_USER,
                          isMyProfile: true,
                        ),
                        dispose: (context, DetailBloc _detailBloc) =>
                            _detailBloc.dispose(),
                      )
                    : Provider(
                        create: (BuildContext context) => AuthBloc(context),
                        child: AuthPage(title: Strings.AuthPage.PAGE_TITLE),
                        dispose: (context, AuthBloc _authBloc) async {
                          _authBloc.dispose();
                          if (_homeBloc.users.isEmpty) {
                            await _homeBloc.getUserList(0, 20);
                          }
                        },
                      ),
              ),
            ),
          )
        ],
      ),
      body: UserList(
        _homeBloc,
      ),
    );
  }
}
