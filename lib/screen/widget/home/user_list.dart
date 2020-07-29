import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/bloc/home_bloc.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/screen/detail_page.dart';
import 'package:github_user_list/screen/widget/home/centered_circular_indicator.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  final HomeBloc _homeBloc;

  UserList(this._homeBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
        initialData: _homeBloc.users,
        stream: _homeBloc.usersStream,
        builder: (context, snapshot) {
          List<User> users = snapshot.data;
          if (users.isEmpty) {
            _homeBloc.getUserList(0, 20);
            return CenteredCircularIndicator();
          } else {
            return ListView.builder(
              itemCount: users.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index >= users.length) {
                  _homeBloc.getUserList(users.last.id, 20);
                  return CenteredCircularIndicator();
                }
                User user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      user.avatarUrl,
                      scale: 16,
                    ),
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
                          dispose: (context, DetailBloc _detailBloc) =>
                              _detailBloc.dispose(),
                        ),
                      )),
                );
              },
            );
          }
        });
  }
}
