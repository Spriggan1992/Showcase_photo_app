import 'package:flutter/material.dart';

class TitleHolder extends StatelessWidget {
  const TitleHolder({
    Key key,
    this.title,
    this.fontSize,
  }) : super(key: key);
  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(fontSize: fontSize, fontFamily: 'Comfortaa'));
  }
}
