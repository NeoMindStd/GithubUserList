import 'package:flutter/material.dart';

class CenterCard extends StatelessWidget {
  final double appBarHeight;
  final Widget child;

  CenterCard({this.appBarHeight = 0, this.child});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 4 - appBarHeight),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(child: child),
          ),
        ),
      );
}
