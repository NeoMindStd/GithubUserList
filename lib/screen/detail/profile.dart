import 'package:flutter/material.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;
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
                        Text(
                            "${_user.followers.length} ${Strings.DetailPage.FOLLOWERS}"),
                      ],
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewPage(
                                "${_user.login}'s ${Strings.DetailPage.FOLLOWERS}",
                                Strings.HTTP.githubTapFollowers(_user.login)))),
                  ),
                  Text(" · "),
                  InkWell(
                    child: Text(
                        "${_user.followings.length} ${Strings.DetailPage.FOLLOWING}"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewPage(
                                "${_user.login}'s ${Strings.DetailPage.FOLLOWING}",
                                Strings.HTTP.githubTapFollowing(_user.login)))),
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
                                "${_user.login}'s ${Strings.DetailPage.STARS}",
                                Strings.HTTP.githubTapStars(_user.login)))),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
