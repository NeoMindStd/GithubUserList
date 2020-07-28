import 'package:flutter/material.dart';
import 'package:github_user_list/data/user.dart';
import 'package:github_user_list/screen/web_view_page.dart';

class Profile extends StatelessWidget {
  final User _user;
  final EdgeInsetsGeometry padding;

  const Profile(
    this._user, {
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(_user.avatarUrl),
              ),
              title: Text(_user.login),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => WebViewPage(_user.login, _user.htmlUrl))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.people_outline),
                        Padding(
                          padding: EdgeInsets.only(left: 2),
                        ),
                        Text("${_user.followers.length} followers"),
                      ],
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewPage(
                                "${_user.login}'s followers",
                                'https://github.com/${_user.login}?tab=followers'))),
                  ),
                  Text(" · "),
                  InkWell(
                    child: Text("${_user.followings.length} following"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewPage(
                                "${_user.login}'s following",
                                'https://github.com/${_user.login}?tab=following'))),
                  ),
                  Text(" · "),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.star_border),
                        Padding(
                          padding: EdgeInsets.only(left: 2),
                        ),
                        Text("${_user.stars.length}"),
                      ],
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewPage(
                                "${_user.login}'s stars",
                                'https://github.com/${_user.login}?tab=stars'))),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
