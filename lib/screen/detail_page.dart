import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/data/repository.dart';
import 'package:github_user_list/data/user.dart';
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
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          List.generate(user.repositories.length, (index) {
                        Repository repo = user.repositories[index];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                repo.name,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(repo.description),
                              Row(
                                children: <Widget>[
                                  Text(repo.language),
                                  Icon(Icons.star_border),
                                  Text('${repo.stargazerCount}'),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
