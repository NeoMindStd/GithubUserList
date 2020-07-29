import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/bloc/home_bloc.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/screen/detail_page.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final double scrollThreshold;
  final HomeBloc _homeBloc;

  UserList(this._homeBloc, {this.scrollThreshold = 200.0});

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(
        () => _homeBloc.onScroll(_scrollController, scrollThreshold));
    _homeBloc.getUserList(0, 20);

    return SingleChildScrollView(
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
    );
  }
}
