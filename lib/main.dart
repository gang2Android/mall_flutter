import 'package:common_utils/common_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/MainPage.dart';
import 'package:flutter_app_01/ui/pro/list/ProListBean.dart';

import './route/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    App.router = router;
    LogUtil.init(isDebug: true);



    return MaterialApp(
      // showPerformanceOverlay: true,
      // checkerboardOffscreenLayers: true,
      // checkerboardRasterCacheImages: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          App.appColor,
          <int, Color>{
            50: Color(0xFFFFFDE7),
            100: Color(0xFFFFF9C4),
            200: Color(0xFFFFF59D),
            300: Color(0xFFFFF176),
            400: Color(0xFFFFEE58),
            500: Color(App.appColor),
            600: Color(0xFFFDD835),
            700: Color(0xFFFBC02D),
            800: Color(0xFFF9A825),
            900: Color(0xFFF57F17),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // onGenerateRoute: App.router.generator,
      home: MainPage(),
      // home: OrderPayPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int sort = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final List<String> _tabs = ['全部', '精品区', '百货区', '名品区', '联盟区'];
    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leading: Icon(Icons.arrow_back),
                  title: Chip(
                    label: Text("搜索"),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: width * 0.32,
                        right: width * 0.32,
                        top: 10,
                        bottom: 10),
                  ),
                  toolbarHeight: 100.0,
                  pinned: true,
                  expandedHeight: 40.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabs: _tabs
                              .map((String name) => Tab(text: name))
                              .toList(),
                        ),
                        Container(
                          color: Colors.grey[300],
                          margin: const EdgeInsets.only(top: 2.0),
                          height: 3.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (this.sort == 1) return;
                                  setState(() {
                                    this.sort = 1;
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "综合",
                                    style: TextStyle(
                                      color: this.sort == 1
                                          ? Color(0xFFFFAC34)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (this.sort == 2) return;
                                  setState(() {
                                    this.sort = 2;
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "销量",
                                    style: TextStyle(
                                      color: this.sort == 2
                                          ? Color(0xFFFFAC34)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (this.sort == 3) return;
                                  setState(() {
                                    this.sort = 3;
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "价格",
                                    style: TextStyle(
                                      color: this.sort == 3
                                          ? Color(0xFFFFAC34)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (this.sort == 4) return;
                                  setState(() {
                                    this.sort = 4;
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "链分值",
                                    style: TextStyle(
                                      color: this.sort == 4
                                          ? Color(0xFFFFAC34)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  if (this.sort == 5) return;
                                  setState(() {
                                    this.sort = 5;
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "链分值比例",
                                    style: TextStyle(
                                      color: this.sort == 5
                                          ? Color(0xFFFFAC34)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Scaffold(
            body: Container(
              margin: const EdgeInsets.only(top: 160.0),
              child: _pro1(),
            ),
          )),
      // body: _pro())
    );
  }

  _pro1() {
    return GridView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return _pro_item(context, index, null);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.8,
      ),
    );
  }

  _pro_item(BuildContext context, int index, ProListItemBean itemBean) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(0.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(itemBean.proimg),
                Container(height: 5.0),
                Text(
                  itemBean.proname,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "￥" + itemBean.vipprice.toString(),
                      style: TextStyle(color: Colors.red, fontSize: 18.0),
                    ),
                    Text(
                      "￥" + itemBean.marketprice.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    RadioListTile()
                  ],
                )
              ],
            )),
      ),
    );
  }

  _pro() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // mainAxisSpacing: 0.0,
        // crossAxisSpacing: 0.0,
        childAspectRatio: 2 / 2.8,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        // var width = MediaQuery.of(context).size.width / 2 - 10;
        return Card(
          child: InkWell(
            onTap: () {},
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(0.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                        "http://img13.360buyimg.com/n1/s400x400_jfs/t1/48372/25/14620/145846/5db84957E7c723365/94f14680e5d77ece.jpg"),
                    Container(height: 5.0),
                    Text(
                      "item.proname",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "￥" + "item.vipprice".toString(),
                          style: TextStyle(color: Colors.red, fontSize: 18.0),
                        ),
                        Text(
                          "￥" + "item.marketprice".toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      }, childCount: 10),
    );
  }
}
