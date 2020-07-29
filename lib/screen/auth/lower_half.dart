import 'package:flutter/material.dart';

class LowerHalf extends StatelessWidget {
  final double appBarHeight;
  LowerHalf({this.appBarHeight = 0});

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: (MediaQuery.of(context).size.height - appBarHeight) / 2,
          color: Color(0xFFECF0F3),
        ),
      );
}
