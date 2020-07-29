import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/auth_bloc.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/bloc/home_bloc.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/screen/auth_page.dart';
import 'package:github_user_list/screen/detail_page.dart';
import 'package:github_user_list/util/data_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String title;
  final ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  HomePage({Key key, this.title = "HomePage"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBloc = Provider.of<HomeBloc>(context);

    _scrollController.addListener(() => _onScroll(_homeBloc));
    _homeBloc.getUserList(0, 20);

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
                      )
                    : Provider(
                        create: (BuildContext context) => AuthBloc(context),
                        child: AuthPage(title: Strings.AuthPage.PAGE_TITLE),
                      ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: StreamBuilder<List<User>>(
            initialData: _homeBloc.users,
            stream: _homeBloc.usersStream,
            builder: (context, snapshot) {
              List<User> users = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(users.length, (index) {
                  User user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    title: Text(user.login),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Provider(
                            create: (BuildContext context) =>
                                DetailBloc(context, user),
                            child: DetailPage(
                              title: Strings.DetailPage.PAGE_TITLE_NORMAL,
                            ),
                          ),
                        )),
                  );
                }),
              );
            }),
      ),
    );
  }

  _onScroll(HomeBloc _homeBloc) {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _homeBloc.getUserList(_homeBloc.users.last.id, 20);
    }
  }
}
