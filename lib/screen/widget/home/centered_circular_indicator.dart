import 'package:flutter/material.dart';

class CenteredCircularIndicator extends StatelessWidget {
  final double width;
  final double height;

  CenteredCircularIndicator({
    this.width = 36,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          width: width,
          height: height,
        ),
      );
}
