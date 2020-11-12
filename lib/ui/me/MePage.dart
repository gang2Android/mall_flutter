import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/base/BaseState.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/me/MeBean.dart';
import 'package:flutter_app_01/ui/user/UserRepository.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller = EasyRefreshController();

  UserRepository _userRepository = UserRepository();

  MeBean _meBean;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
        centerTitle: true,
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.settings),
            ),
            onTap: () {
              var result = App.router.navigateTo(context, Routes.setPage);
              result.then((value) {
                if (value is bool) {
                  if (value) {
                    _meBean = null;
                    setState(() {});
                  }
                }
              });
            },
          )
        ],
        elevation: 0.0,
      ),
      body: EasyRefresh(
        header: BallPulseHeader(),
        // footer: BallPulseFooter(),
        topBouncing: true,
        bottomBouncing: true,
        controller: _controller,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            _userInfoView(),
            _accountView(),
            _orderView(),
            _funView(),
          ],
        ),
      ),
    );
  }

  _userInfoView() {
    String imgUrl = "https://web.mall.345678.com.cn/static/my/user.png";
    String name = "用户昵称";
    String levelName = "轻节点";
    String code = "123456";
    String hashUrl = "http://xxx.com/";
    if (_meBean != null) {
      imgUrl = _meBean.AvatarUrl;
      name = _meBean.Nickname;
      levelName = _meBean.userType;
      code = _meBean.invitecode;
      hashUrl = _meBean.user_block_hash;
    }
    return SliverToBoxAdapter(
      child: Container(
        color: Color(App.appColor),
        padding: const EdgeInsets.only(
            left: 20.0, top: 10.0, right: 0.0, bottom: 10.0),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(42),
              ),
              child: ClipOval(
                child: Image.network(imgUrl, width: 50.0, height: 50.0),
              ),
            ),
            Container(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                    Container(width: 5.0),
                    Chip(
                      padding: EdgeInsets.only(
                          left: 5.0, top: 0.0, bottom: 0.0, right: 5.0),
                      labelPadding: EdgeInsets.only(
                          left: 5.0, top: -5.0, bottom: -5.0, right: 5.0),
                      label: Text(
                        levelName,
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("邀请码:$code",
                        style: TextStyle(fontSize: 12.0, color: Colors.black)),
                    Container(width: 5.0),
                    InkWell(
                      child: Text(
                        "点击复制",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          // decorationStyle: TextDecorationStyle.dotted,
                        ),
                      ),
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: "邀请码：$code"),
                        );
                        Toast.toast(context, "已复制到剪贴板");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _accountView() {
    String num0 = "0.00";
    String num1 = "0.00";
    String num2 = "0.00";
    if (_meBean != null) {
      num0 = _meBean.Umoney;
      num1 = _meBean.Pv;
      num2 = _meBean.repeat_money;
    }

    return SliverToBoxAdapter(
      child: Container(
        color: Color(App.appColor),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    num0,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Text(
                    "余额",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    num1,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Text(
                    "奖金",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    num2,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Text(
                    "推荐奖",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _orderView() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: Colors.white70,
            width: 0.5,
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("我的订单", style: TextStyle(fontSize: 16.0)),
                Expanded(child: Container()),
                InkWell(
                  child: Text(
                    "查看全部>",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[400],
                    ),
                  ),
                  onTap: () {
                    _openOrderList(0);
                  },
                ),
              ],
            ),
            Container(
              height: 1.0,
              color: Colors.grey[350],
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.payment, size: 40.0),
                        Text("待付款", style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                    onTap: () {
                      _openOrderList(1);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.payment, size: 40.0),
                        Text("待发货", style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                    onTap: () {
                      _openOrderList(2);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.payment, size: 40.0),
                        Text("待收货", style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                    onTap: () {
                      _openOrderList(3);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.payment, size: 40.0),
                        Text("已收货", style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                    onTap: () {
                      _openOrderList(4);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.payment, size: 40.0),
                        Text("售后", style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                    onTap: () {
                      print("售后");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _funView() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: Colors.white70,
            width: 0.5,
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("常用功能", style: TextStyle(fontSize: 16.0)),
            Container(
              height: 1.0,
              color: Colors.grey[350],
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.store, size: 35.0),
                        Text(
                          "收货地址",
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      App.router.navigateTo(context, Routes.addressListPage);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.store, size: 35.0),
                        Text(
                          "我的收藏",
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      App.router.navigateTo(context, Routes.collectListPage);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.store, size: 35.0),
                        Text(
                          "我的团队",
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      print("我的团队");
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.store, size: 35.0),
                        Text(
                          "我要分享",
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      App.router.navigateTo(context, Routes.userSharePage);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _openOrderList(int index) {
    App.router.navigateTo(context, Routes.orderListPage + "?index=$index").then(
      (value) {
        if (value is bool) {
          if (value) {
            _getUserData();
          }
        }
      },
    );
  }

  /// **************************************************************************

  Future<void> _onRefresh() async {
    _getUserData();
  }

  _getUserData() {
    _userRepository.getUserInfo((data) {
      _controller.resetLoadState();
      _controller.finishRefresh();
      _meBean = data;
      setState(() {});
    }, (error) {
      // Toast.toast(context, error, isError: true);
    });
  }
}
