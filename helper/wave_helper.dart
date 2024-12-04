import 'package:flutter/material.dart';

class Wave {
  static int time = 1200;
  static Widget tube(double width, double height, double gradient,
      {double? radius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? height / 2),
          gradient: LinearGradient(
              begin: Alignment(gradient, 0),
              end: const Alignment(-1, 0),
              colors: [Colors.grey[200]!, Colors.white, Colors.grey[200]!])),
    );
  }

  static Widget expand(double gradient, {double radius = 12}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
              begin: Alignment(gradient, 0),
              end: const Alignment(-1, 0),
              colors: [Colors.grey[200]!, Colors.white, Colors.grey[200]!])),
    );
  }
}
