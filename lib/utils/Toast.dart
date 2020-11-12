import 'package:flutter/material.dart';

/// Toast
/// Toast.toast(context, "text", onTap: (){
///   // do something...
/// });
class Toast {
  static OverlayEntry _overlayEntry;
  static DateTime _startedTime;

  static void toast(BuildContext context, String msg,
      {Function onTap, bool isError = false, int time = 2000}) async {
    assert(msg != null);
    _startedTime = DateTime.now();
    OverlayState overlayState = Overlay.of(context);
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          child: Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: msg.length >= 20 ? 80.0 : 50.0,
            child: Card(
              child: InkWell(
                child: Container(
                  color: isError ? Colors.red : Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: _contentView(msg, isError),
                  ),
                ),
                onTap: () {
                  if (_overlayEntry == null) return;
                  _overlayEntry.remove();
                  _overlayEntry.markNeedsBuild();
                  _overlayEntry = null;
                  if (onTap != null) {
                    onTap();
                  }
                },
              ),
            ),
          ),
        ),
      );
      overlayState.insert(_overlayEntry);
    } else {
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: time));

    if (DateTime.now().difference(_startedTime).inMilliseconds >= time) {
      if (_overlayEntry == null) return;
      _overlayEntry.remove();
      _overlayEntry.markNeedsBuild();
      _overlayEntry = null;
    }
  }

  static _contentView(String msg, bool isError) {
    List<Widget> views = List();
    if (isError) {
      views.add(
        Icon(Icons.error, color: Colors.white),
      );
      views.add(Container(width: 10.0));
    }

    views.add(
      Expanded(
        child: Text(
          msg,
          style: TextStyle(
            fontSize: 14.0,
            color: isError ? Colors.white : Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
    return views;
  }
}
