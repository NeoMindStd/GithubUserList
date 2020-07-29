import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/auth_bloc.dart';
import 'package:github_user_list/screen/widget/auth/login_card.dart';
import 'package:github_user_list/screen/widget/auth/lower_half.dart';
import 'package:github_user_list/screen/widget/auth/upper_half.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  final String title;

  AuthPage({Key key, this.title = "ProfilePage"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = Provider.of<AuthBloc>(context);
    final AppBar _appbar = AppBar(
      title: Text(title),
    );

    return Scaffold(
      appBar: _appbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: <Widget>[
            LowerHalf(
              appBarHeight: _appbar.preferredSize.height,
            ),
            UpperHalf(
              appBarHeight: _appbar.preferredSize.height,
            ),
            LoginCard(
              _authBloc,
              appBarHeight: _appbar.preferredSize.height,
            ),
          ]),
        ),
      ),
    );
  }
}
