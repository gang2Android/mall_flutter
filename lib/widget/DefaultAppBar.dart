import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;

  DefaultAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(title == null ? "" : title),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
