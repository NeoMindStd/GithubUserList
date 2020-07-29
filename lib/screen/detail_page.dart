import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/detail_bloc.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/screen/widget/detail/profile.dart';
import 'package:github_user_list/screen/widget/detail/repo_list.dart';
import 'package:github_user_list/util/data_manager.dart';
import 'package:github_user_list/util/dialog.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final bool isMyProfile;

  DetailPage({Key key, this.title = "DetailPage", this.isMyProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailBloc _detailBloc = Provider.of<DetailBloc>(context);

    _detailBloc.getUserDetailInfo();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[] +
            (isMyProfile
                ? [
                    MaterialButton(
                      child: Text(
                        Strings.Global.LOGOUT,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onPressed: () => AppDialog(context)
                          .showYesNoDialog(Strings.DetailPage.DIALOG_MSG_LOGOUT,
                              onConfirm: () async {
                        await DataManager().logout();
                        Navigator.pop(context);
                      }),
                    )
                  ]
                : []),
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
