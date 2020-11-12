import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';

class CheckboxWidget extends StatefulWidget {
  final String text;
  final bool isCheck;
  final Function(bool checked) onChange;

  const CheckboxWidget({Key key, this.text, this.onChange, this.isCheck})
      : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.isCheck;
    print("initState=$_value");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        if (widget.onChange != null) widget.onChange(_value);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _value
                ? Icon(
                    Icons.check_circle,
                    size: 20.0,
                    color: Color(App.appColor),
                  )
                : Icon(
                    Icons.check_circle_outline,
                    size: 20.0,
                  ),
          ),
          Text(
            widget.text == null ? " " : widget.text,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
