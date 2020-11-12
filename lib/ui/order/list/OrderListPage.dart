import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/order/OrderInfoBean.dart';
import 'package:flutter_app_01/ui/order/OrderRepository.dart';
import 'package:flutter_app_01/ui/order/list/OrderListBean.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class OrderListPage extends StatefulWidget {
  final int index;

  const OrderListPage({Key key, this.index}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  EasyRefreshController _controller = EasyRefreshController();

  List<String> _tabs = List();

  int _index = 0;
  int _page = 1;
  String _shop_type = "";

  bool _isEmpty = false;

  OrderRepository _orderRepository = OrderRepository();
  List<OrderListBean> _orderListBean;

  @override
  void initState() {
    super.initState();
    _tabs.add("全部");
    _tabs.add("待付款");
    _tabs.add("待发货");
    _tabs.add("待收货");
    _tabs.add("待评价");

    _index = widget.index;
    _tabController =
        TabController(length: _tabs.length, vsync: this, initialIndex: _index);

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("我的订单"),
          centerTitle: true,
          toolbarHeight: 100.0,
          backgroundColor: Color(App.appColor),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: _topView(),
          ),
        ),
        body: _bodyView(),
      ),
    );
  }

  _topView() {
    return Column(
      children: [
        Container(
          height: 1.0,
          color: Color(0x88D6D6D6),
        ),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          onTap: (index) {
            // String type = "";
            // switch (index) {
            //   case 0:
            //     type = "";
            //     break;
            //   case 1:
            //     type = "1";
            //     break;
            //   case 2:
            //     type = "2";
            //     break;
            //   case 3:
            //     type = "4";
            //     break;
            //   case 4:
            //     type = "7";
            //     break;
            // }
            this._index = index;
            this._page = 1;
            // this._shop_type = type;
            _getData();
          },
        ),
      ],
    );
  }

  _bodyView() {
    return EasyRefresh(
      header: BallPulseHeader(),
      footer: BallPulseFooter(),
      topBouncing: true,
      bottomBouncing: true,
      controller: _controller,
      onRefresh: _onRefresh,
      onLoad: () async {
        _getData(isLoadMore: true);
      },
      child: ListView.builder(
        itemCount: _orderListBean == null ? 0 : _orderListBean.length,
        itemBuilder: (BuildContext context, int index) {
          OrderListBean item = _orderListBean[index];
          return _supItemView(item, index);
        },
      ),
      emptyWidget: _emptyView(),
    );
  }

  _supItemView(OrderListBean item, int index) {
    List<Widget> items = List();
    items.add(
      Row(
        children: [
          Text(
            "${item.supname}",
            style: TextStyle(
              fontSize: 16.0,
              color: Color(App.appColor),
            ),
          ),
          Expanded(child: Container()),
          Text(
            "${item.staname}",
            style: TextStyle(
              fontSize: 18.0,
              color: Color(App.appColor),
            ),
          ),
        ],
      ),
    );

    items.add(Container(height: 5.0));

    item.voo.forEach(
      (element) {
        items.add(_proItemView(element));
      },
    );
    items.add(
      Row(
        children: [
          Text(
            "下单时间：",
            style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
          ),
          Expanded(child: Container()),
          InkWell(
            child: Text(
              "${item.adddate}",
              style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
    items.add(
      Row(
        children: [
          Text(
            "订单号：",
            style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
          ),
          Expanded(child: Container()),
          InkWell(
            child: Text(
              "${item.innerorderid}",
              style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
    items.add(
      Row(
        children: [
          Text(
            "合计金额：",
            style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
          ),
          Expanded(child: Container()),
          InkWell(
            child: Text(
              "￥${item.orderamount}（含运费￥${item.freight}）",
              style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
    List<Widget> btns = List();
    btns.add(
      RaisedButton(
        onPressed: () {
          App.router.navigateTo(context,
              Routes.orderDetailPage + "?orderNo=${item.innerorderid}");
        },
        child: Text("查看订单"),
      ),
    );
    switch (item.status) {
      /* 待支付 */
      case "1":
        btns.add(
          RaisedButton(
            onPressed: () {
              var data = OrderInfoBean(
                  item.innerorderid, item.orderamount, item.freight,"inner");
              String info = json.encode(data.toJson());
              App.router
                  .navigateTo(context, Routes.orderPayPage + "?info=$info");
            },
            child: Text("支付"),
          ),
        );
        btns.add(Container(width: 5.0));
        break;
      /* 已取消 */
      case "10":
        break;
    }
    items.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: btns,
      ),
    );

    var supItemView = Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.grey[300],
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Column(
        children: items,
      ),
    );
    return InkWell(
      child: supItemView,
      onTap: () {
        App.router.navigateTo(
            context, Routes.orderDetailPage + "?orderNo=${item.innerorderid}");
      },
    );
  }

  Widget _proItemView(OrderListProBean element) {
    return Row(
      children: [
        Image.network(element.spec_img, width: 100, height: 100),
        Container(width: 5.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                element.proname,
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                element.stylename,
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    "￥",
                    style: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                  Expanded(
                    child: Text(
                      "${element.vipPrice}",
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    ),
                  ),
                  Text(
                    "￥",
                    style: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                  Text(
                    "${element.pronum}",
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _emptyView() {
    if (_isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text("没有数据了"),
      );
    }
    return null;
  }

  /// **************************************************************************
  Future<void> _onRefresh() async {
    _getData();
  }

  _getData({isLoadMore: false}) {
    if (!isLoadMore) {
      _page = 1;
      this._orderListBean = null;
      setState(() {});
    }
    _orderRepository.getOrderList(
      _page,
      _shop_type,
      _index,
      (data) {
        _page = _page + 1;
        _isEmpty = false;
        if (this._orderListBean == null) this._orderListBean = List();
        this._orderListBean.addAll(data);
        setState(() {});
        try {
          _controller.resetLoadState();
          if (isLoadMore) {
            _controller.finishLoad(noMore: false);
          } else {
            _controller.finishRefresh();
          }
        } catch (e) {
          _controller = EasyRefreshController();
          _controller.resetLoadState();
          if (isLoadMore) {
            _controller.finishLoad(noMore: false);
          } else {
            _controller.finishRefresh();
          }
        }
      },
      (error) {
        Toast.toast(context, error, isError: true);
        print("error=" + error + "---page=$_page");
        try {
          _controller.resetLoadState();
          if (isLoadMore) {
            _controller.finishLoad(noMore: _page != 1);
          } else {
            _controller.finishRefresh();
          }
        } catch (e) {
          _controller = EasyRefreshController();
          _controller.resetLoadState();
          if (isLoadMore) {
            _controller.finishLoad(noMore: _page != 1);
          } else {
            _controller.finishRefresh();
          }
        }
        if (_page == 1) {
          _isEmpty = true;
          setState(() {});
        }
        // if (_page != 1) {
        //   this._page--;
        // }
      },
    );
  }

  /// 未知错误,暂时以这种方式处理
  /// 问题链接：https://github.com/xuelongqy/flutter_easyrefresh/issues/352
  _hanError(isLoadMore) {
    try {
      _controller.resetLoadState();
      if (isLoadMore) {
        _controller.finishLoad(noMore: true);
      } else {
        _controller.finishRefresh();
      }
    } catch (e) {
      print(e);
      _controller = EasyRefreshController();
      _controller.resetLoadState();
      if (isLoadMore) {
        _controller.finishLoad(noMore: false);
      } else {
        _controller.finishRefresh();
      }
    }
  }
}
