import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/data/user.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String title;

  DetailPage({Key key, this.title = "DetailPage"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailBloc _detailBloc = Provider.of<DetailBloc>(context);

    _detailBloc.getUserDetailInfo();

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
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  title: Text(user.login),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.people_outline),
                    Text("${user.followers.length} followers"),
                    Text(" · "),
                    Text("${user.followings.length} following"),
                    Text(" · "),
                    Icon(Icons.star_border),
                    Text("${user.stars.length}"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Repositories "),
                    Text("${user.repositories.length}"),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
