import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/DefaultAppBar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class UserSharePage extends StatefulWidget {
  @override
  _UserSharePageState createState() => _UserSharePageState();
}

class _UserSharePageState extends State<UserSharePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("我的二维码"),
      body: Container(
        child: _contentView(),
      ),
    );
  }

  _contentView() {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 1.1,
                  child: Swiper(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return _itemView(index);
                    },
                    viewportFraction: 0.8,
                    scale: 0.8,
                    pagination: SwiperPagination(
                      // 分页指示器
                      alignment: Alignment.bottomCenter,
                      // 位置 Alignment.bottomCenter 底部中间
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      // 距离调整
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Color(App.appColor),
                        color: Colors.black,
                        size: 8.0,
                        activeSize: 10.0,
                        space: 5.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(height: 1.0, color: Colors.grey),
        InkWell(
          child: Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              children: [
                Icon(Icons.ios_share),
                Text("微信"),
              ],
            ),
            color: Colors.white,
          ),
          onTap: (){
            Toast.toast(context, "分享");
          },
        ),
      ],
    );
  }

  _itemView(int index) {
    var view;
    switch (index) {
      case 0:
        view = _firstView();
        break;
      case 1:
        view = _twoView();
        break;
      case 2:
        view = _threeView();
        break;
    }
    return view;
  }

  _firstView() {
    return Card(
      margin: const EdgeInsets.only(bottom: 35.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(App.appColor),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(42),
                      ),
                      child: ClipOval(
                        child: Image.network(
                            "https://web.mall.345678.com.cn/static/my/user.png",
                            width: 50.0,
                            height: 50.0),
                      ),
                    ),
                    Container(width: 10.0),
                    Text(
                      "宣传语",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    Container(width: 10.0),
                    Text(
                      "向您发出了邀请",
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(42),
                  ),
                  margin: const EdgeInsets.only(top: 50.0),
                  child: ClipOval(
                    child: Image.network(
                        "https://web.mall.345678.com.cn/static/my/user.png",
                        width: 50.0,
                        height: 50.0),
                  ),
                ),
                Container(height: 10.0),
                Text(
                  "昵称",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Container(height: 30.0),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "App名称",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(App.appColor),
                      ),
                    ),
                    Container(height: 10.0),
                    Text(
                      "长按识别图中二维码",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    Container(height: 5.0),
                    Text(
                      "或扫描图中二维码",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Image.network(
                      "http://mem.mall.345678.com.cn//api.php/index/Plugin/qrcode?text=https://web.mall.345678.com.cn/%23/pages/login/register?UserId=11255",
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _twoView() {
    return Card(
      margin: const EdgeInsets.only(bottom: 35.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(42),
                  ),
                  child: ClipOval(
                    child: Image.network(
                        "https://web.mall.345678.com.cn/static/my/user.png",
                        width: 50.0,
                        height: 50.0),
                  ),
                ),
                Container(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "昵称",
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                    Text(
                      "向您发出了邀请",
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "App名称",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(App.appColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(App.appColor),
              ),
              child: Column(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(42),
                    ),
                    margin: const EdgeInsets.only(top: 5.0),
                    child: ClipOval(
                      child: Image.network(
                          "https://web.mall.345678.com.cn/static/my/user.png",
                          width: 50.0,
                          height: 50.0),
                    ),
                  ),
                  Container(height: 10.0),
                  Text(
                    "App名称",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Container(height: 30.0),
                  Image.network(
                    "http://mem.mall.345678.com.cn//api.php/index/Plugin/qrcode?text=https://web.mall.345678.com.cn/%23/pages/login/register?UserId=11255",
                    width: 100.0,
                    height: 100.0,
                  ),
                  Container(height: 10.0),
                  Text(
                    "长按识别图中二维码",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  Container(height: 5.0),
                  Text(
                    "或扫描图中二维码",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _threeView() {}
}
