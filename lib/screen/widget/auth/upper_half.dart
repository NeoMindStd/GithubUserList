import 'package:flutter/material.dart';

class UpperHalf extends StatelessWidget {
  final double appBarHeight;
  UpperHalf({this.appBarHeight = 0});

  @override
  Widget build(BuildContext context) => Container(
        height: (MediaQuery.of(context).size.height - appBarHeight) / 2,
        color: Colors.black87,
      );
}
