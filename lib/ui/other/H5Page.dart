import 'package:flutter/material.dart';
import 'package:flutter_app_01/base/BaseState.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class H5Page extends StatefulWidget {
  final String data;
  final String title;
  final bool isUrl;

  const H5Page({Key key, @required this.data, this.title, this.isUrl = false})
      : super(key: key);

  @override
  _H5PageState createState() => _H5PageState();
}

class _H5PageState extends BaseState<H5Page> {
  @override
  Widget getContentWidget(BuildContext context) {
    print(widget.data);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.title.isNotEmpty ? widget.title : " "),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
        child: HtmlWidget(
          widget.data,
          onTapUrl: (url) async {
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
      ),
    );
  }
}
