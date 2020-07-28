import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/screen/detail/profile.dart';
import 'package:github_user_list/screen/detail/repo_list.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String title;

  DetailPage({Key key, this.title = "DetailPage"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailBloc _detailBloc = Provider.of<DetailBloc>(context);

    _detailBloc.getUserDetailInfoStub();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<User>(
          initialData: _detailBloc.user,
          stream: _detailBloc.userStream,
          builder: (context, snapshot) {
            User user = snapshot.data;
            return Column(
              children: <Widget>[
                Profile(
                  user,
                  padding: EdgeInsets.all(20),
                ),
                Divider(
                  height: 2,
                  thickness: 0.5,
                  color: Colors.black54,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                RepoList(
                  user.repositories,
                  titlePadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
