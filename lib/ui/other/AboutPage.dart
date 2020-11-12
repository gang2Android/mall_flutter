import 'package:flutter/material.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/DefaultAppBar.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _packageName = "";
  String _version = "版本号 1.0";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      // {appName=flutter_app_01,packageName=com.example.flutter_app_01,version=1.0.0,buildNumber=1}
      _packageName = packageInfo.packageName;
      _version = "版本号 " + packageInfo.version;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("关于"),
      body: Container(
        padding: const EdgeInsets.only(top: 50.0),
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/logo.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                  Text(_version),
                  Container(height: 30.0),
                ],
              ),
              ListTile(
                title: Text("检查更新"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  _checkVersion();
                },
              ),
              ListTile(
                title: Text("关于我们"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  _openAboutUrl();
                },
              ),
              ListTile(
                title: Text("去评分"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () async {
                  String url = "market://details?id=" + _packageName;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    Toast.toast(context, "未找到该应用");
                  }
                },
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }

  void _checkVersion() {
    Toast.toast(context, "检查版本更新");
  }

  void _openAboutUrl() {
    Toast.toast(context, "打开关于我们页面");
  }
}
