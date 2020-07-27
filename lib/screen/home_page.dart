import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/home_bloc.dart';
import 'package:github_user_list/data/user.dart';
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
    _homeBloc.getUserListStub(0, 20);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      _homeBloc.getUserListStub(_homeBloc.users.length - 1, 20);
    }
  }
}
