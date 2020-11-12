import 'package:flutter/material.dart';

class CountView extends StatefulWidget {
  final int num;
  final int max;
  final Function callBack;

  CountView({Key key, this.num, this.max, this.callBack}) : super(key: key);

  @override
  _CountViewState createState() => _CountViewState();
}

class _CountViewState extends State<CountView> {
  int _num;
  int _max;
  Function _callBack;

  double _btnWidth = 35.0;
  double _btnHeight = 35.0;
  double _txtWidth = 50.0;
  double _txtHeight = 35.0;

  @override
  void initState() {
    super.initState();
    this._num = widget.num;
    this._max = widget.max;
    this._callBack = widget.callBack;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        children: [
          _leftView(context),
          _centerView(context),
          _rightView(context),
        ],
      ),
    );
  }

  _leftView(BuildContext context) {
    return InkWell(
      child: Container(
        width: _btnWidth,
        height: _btnHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _num > 1 ? Colors.white : Colors.black12,
          border: Border(
            right: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Text(
          '-',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      onTap: () {
        if (_num == 1) return;
        _num = _num - 1;
        setState(() {});
        _callBack(_num);
      },
    );
  }

  _centerView(BuildContext context) {
    return Container(
      width: _txtWidth,
      height: _txtHeight,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '$_num',
        style: TextStyle(fontSize: 14.0, color: Colors.black),
      ),
    );
  }

  _rightView(BuildContext context) {
    return InkWell(
      child: Container(
        width: _btnWidth,
        height: _btnHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _num < _max ? Colors.white : Colors.black12,
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Text(
          '+',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      onTap: () {
        if (_num == _max) return;
        _num = _num + 1;
        setState(() {});
        _callBack(_num);
      },
    );
  }
}
