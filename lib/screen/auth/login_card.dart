import 'package:flutter/material.dart';
import 'package:github_user_list/bloc/auth_bloc.dart';
import 'package:github_user_list/screen/auth/center_card.dart';

class LoginCard extends StatelessWidget {
  final AuthBloc _authBloc;
  final double appBarHeight;

  LoginCard(this._authBloc, {this.appBarHeight = 0});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final TextFormField accountField = TextFormField(
      decoration: InputDecoration(
        labelText: "username",
        hasFloatingPlaceholder: true,
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: usernameController.clear,
        ),
      ),
      controller: usernameController,
    );
    final passwordField = StreamBuilder<bool>(
      initialData: _authBloc.isObscureText,
      stream: _authBloc.isObscureTextStream,
      builder: (context, snapshot) => TextFormField(
        decoration: InputDecoration(
          labelText: "password",
          hasFloatingPlaceholder: true,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              IconButton(
                icon: Icon(
                    snapshot.data ? Icons.visibility_off : Icons.visibility),
                onPressed: _authBloc.switchObscureTextMode,
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: passwordController.clear,
              ),
            ],
          ),
        ),
        controller: passwordController,
        obscureText: snapshot.data,
      ),
    );

    return Column(
      children: <Widget>[
        CenterCard(
          appBarHeight: appBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "로그인",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              accountField,
              SizedBox(
                height: 20,
              ),
              passwordField,
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  FlatButton(
                    child: Text(
                      "로그인",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: 38, right: 38, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () => _authBloc.login(
                      context,
                      username: usernameController.text,
                      password: passwordController.text,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
