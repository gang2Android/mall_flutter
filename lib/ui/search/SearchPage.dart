import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          controller: _inputController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            fillColor: Colors.white,
            filled: true,
            hintText: "请输入搜索关键词",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, size: 30.0),
              onPressed: () {
                var text = _inputController.text;
                if (text.length == 0) {
                  return;
                }
                _inputController.clear();
                App.router.navigateTo(
                  context,
                  Routes.proListPage + "?key=$text",
                  replace: true,
                );
              }),
        ],
      ),
      body: Container(
        child: Text(""),
      ),
    );
  }
}
