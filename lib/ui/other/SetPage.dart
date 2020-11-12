import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/DefaultAppBar.dart';
import 'package:package_info/package_info.dart';

class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  String _version = "版本号 1.0";

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      // {appName=flutter_app_01,packageName=com.example.flutter_app_01,version=1.0.0,buildNumber=1}
      _version = "版本号 " + packageInfo.version;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("设置"),
      body: CustomScrollView(
        slivers: [
          _userView(),
          _aboutView(),
          _accountView(),
        ],
      ),
    );
  }

  _userView() {
    List<String> items = List();
    items.add("修改密码");
    return SliverList(
      delegate:
          new SliverChildBuilderDelegate((BuildContext context, int index) {
        return ListTile(
          title: Text(
            items[index],
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        );
      }, childCount: items.length),
    );
  }

  _itemView() {
    return Container(
      child: ListTile(title: Text(""),),
    );
  }

  _aboutView() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              title: Text("关于"),
              trailing: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    _version,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
              onTap: () {
                App.router.navigateTo(context, Routes.aboutPage);
              },
            ),
          ],
        ),
      ),
    );
  }

  _accountView() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              title: Text("退出登录"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                App.token_mem = "";
                App.token = "";
                Navigator.of(context).pop(true);
                Toast.toast(context, "退出登录");
              },
            ),
          ],
        ),
      ),
    );
  }
}
