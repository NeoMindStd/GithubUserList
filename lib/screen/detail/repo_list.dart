import 'package:flutter/material.dart';
import 'package:github_user_list/data/repository.dart';
import 'package:github_user_list/screen/web_view_page.dart';

class RepoList extends StatelessWidget {
  final List<Repository> _repos;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry listPadding;

  const RepoList(this._repos,
      {this.titlePadding = const EdgeInsets.all(0),
      this.listPadding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: <Widget>[
            Padding(
              padding: titlePadding,
              child: Row(
                children: <Widget>[
                  Text(
                    "Repositories ${_repos.length}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: listPadding,
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_repos.length, (index) {
                    Repository repo = _repos[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  repo.name,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(repo.description),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.star_border),
                                    Text('${repo.stargazersCount}'),
                                    Spacer(),
                                    Text(repo.language),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    WebViewPage(repo.name, repo.htmlUrl))),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      );
}
