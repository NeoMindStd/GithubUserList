import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatelessWidget {
  final String title;
  final String url;

  const WebViewPage(this.title, this.url)
      : assert(title != null),
        assert(url != null);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(size: 28, color: Colors.white),
        ),
        body: EasyWebView(
          src: url,
          isHtml: false, // Use Html syntax
          isMarkdown: false, // Use markdown syntax
          // width: 100,
          // height: 100,
        ),
      );
}
