import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';

class Checkbox2Widget extends StatelessWidget {
  final bool isCheck;
  final String text;

  const Checkbox2Widget({Key key, this.isCheck, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            isCheck ? Icons.check_circle : Icons.check_circle_outline,
            size: 20.0,
            color: isCheck ? Color(App.appColor) : null,
          ),
        ),
        Text(
          text == null ? "" : text,
          style: TextStyle(fontSize: 14.0, color: Colors.black),
        ),
      ],
    );
  }
}
