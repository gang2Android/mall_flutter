import 'package:flutter/material.dart';

class KeyboardItem extends StatefulWidget {
  final String text;
  final callback;
  final double keyHeight;

  const KeyboardItem({Key key, this.callback, this.text, this.keyHeight})
      : super(key: key);

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<KeyboardItem> {
  double keyHeight = 44;
  double txtSize = 18;
  String text;

  @override
  void initState() {
    super.initState();
    text = widget.text;
    if (text == "commit") {
      text = "确定";
      txtSize = 16;
    } else if (text == "del") {
      txtSize = 16;
      text = "删除";
    } else {
      txtSize = 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width;
    if (null != widget.keyHeight) {
      keyHeight = widget.keyHeight;
    }
    return Container(
      height: keyHeight,
      width: _screenWidth / 3,
      child: OutlineButton(
        onPressed: widget.callback,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: txtSize,
          ),
        ),
      ),
    );
  }
}