import 'package:flutter/material.dart';

class Custom_text_style extends Text{

  Custom_text_style({
    required String data,
    Color color = Colors.black,
    double size = 18,
    weight = FontWeight.normal,
    style = FontStyle.normal
  }) : super(
    data,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontStyle: style
      )
  );

}