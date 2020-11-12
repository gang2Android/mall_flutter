import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/order/affirm/OrderAffirmBean.dart';
import 'package:flutter_app_01/ui/order/pay/OrderPayPage.dart';
import 'package:flutter_app_01/ui/order/OrderRepository.dart';
import 'package:flutter_app_01/utils/Toast.dart';

class OrderAffirmPage extends StatefulWidget {
  final String cartIds;
  final bool isCart;
  final String shopType;
  final String proid;
  final String styleid;
  final String pronum;
  final String addressId;

  const OrderAffirmPage(
      {Key key,
      this.cartIds,
      this.shopType,
      this.isCart = true,
      this.proid,
      this.styleid,
      this.pronum,
      this.addressId})
      : super(key: key);

  @override
  _OrderAffirmPageState createState() => _OrderAffirmPageState();
}

class _OrderAffirmPageState extends State<OrderAffirmPage> {
  OrderRepository _orderRepository = OrderRepository();
  OrderAffirmBean _orderAffirmBean;

  @override
  void initState() {
    super.initState();

    if (widget.isCart) {
      _orderRepository.getAffirmInfo(widget.cartIds, widget.shopType, _success,
          (error) {
        Toast.toast(context, error.toString(), isError: true);
      });
    } else {
      _orderRepository.getAffirmInfoBuy(widget.proid, widget.styleid,
          widget.pronum, widget.addressId, _success, (error) {
        Toast.toast(context, error.toString(), isError: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("确认订单"),
        centerTitle: true,
      ),
      body: _bodView(),
    );
  }

  _bodView() {
    if (_orderAffirmBean == null) {
      return Container(
        alignment: Alignment.center,
        child: Text("暂无数据"),
      );
    }
    return Column(
      children: [
        _addressView(),
        Expanded(child: _contentView()),
        _bottomView(),
      ],
    );
  }

  _addressView() {
    OrderAffirmAddressBean addressBean = _orderAffirmBean.address;
    return InkWell(
      onTap: () {
        print("address");
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 1), color: Colors.grey[400], blurRadius: 5.0),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.location_on),
            Container(width: 5.0),
            Expanded(
              child: _addressItemView(addressBean),
            ),
            Container(width: 5.0),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }

  _addressItemView(OrderAffirmAddressBean addressBean) {
    if (addressBean == null) {
      return Container(
        child: Text("点击添加收货地址"),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${addressBean.name}     ${addressBean.mobile}",
          style: TextStyle(fontSize: 14.0, color: Colors.black),
        ),
        Text(
          "${addressBean.addressInfo}",
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  _contentView() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              OrderAffirmSupBean item = _orderAffirmBean.groupcart[index];
              return Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _supView(item, index),
                  ),
                ),
              );
            },
            childCount: _orderAffirmBean.groupcart.length,
          ),
        ),
      ],
    );
  }

  _supView(OrderAffirmSupBean item, int index) {
    List<Widget> items = List();
    var top = Row(
      children: [
        Text(
          item.supname,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ],
    );
    items.add(top);

    for (int i = 0; i < item.voo.length; i++) {
      OrderAffirmSupProBean itemPro = item.voo[i];
      items.add(_supProItemView(itemPro, index, i));
      items.add(
        Container(
          height: 1.0,
          color: Colors.grey[300],
          margin: const EdgeInsets.only(bottom: 5.0),
        ),
      );
    }
    items.add(_supBotView(item));

    return items;
  }

  _supProItemView(OrderAffirmSupProBean item, int supIndex, int proIndex) {
    return Row(
      children: [
        Image.network(item.img, width: 100, height: 100),
        Container(width: 5.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.proname,
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                item.stylename,
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
                      "${item.shopprice}",
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    ),
                  ),
                  Text(
                    "X ${item.pronum}",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _supBotView(OrderAffirmSupBean item) {
    return Column(
      children: [
        Row(
          children: [
            Text("商品数量"),
            Expanded(child: Container()),
            Text("${item.pronum}")
          ],
        ),
        Row(
          children: [
            Text("运费"),
            Expanded(child: Container()),
            Text("${item.fregiht}")
          ],
        ),
        Row(
          children: [
            Text("会员价"),
            Expanded(child: Container()),
            Text("${item.viptotal}")
          ],
        ),
      ],
    );
  }

  _bottomView() {
    return Container(
      color: Colors.white,
      height: 56.0,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              // height: 56.0,
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("商品金额：${_orderAffirmBean.viptotal}"),
                  Text("运费：${_orderAffirmBean.zero_fright}"),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              height: 56.0,
              width: MediaQuery.of(context).size.width * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(App.appColor),
              ),
              // padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Text(
                "提交订单",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            onTap: () {
              _getOrderInfo();
            },
          ),
        ],
      ),
    );
  }

  /// **************************************************************************

  _success(data) {
    print(data);
    _orderAffirmBean = data;
    setState(() {});
  }

  _getOrderInfo() {
    if (widget.isCart) {
      _orderRepository.getOrder(
        _orderAffirmBean.address.id,
        widget.cartIds,
        _orderAffirmBean.ordermark,
        (data) {
          data.ordertype = "outer";
          String orderInfo = json.encode(data.toJson());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => OrderPayPage(
                orderInfo: orderInfo,
              ),
            ),
            result: true,
          );
        },
        (error) {
          Toast.toast(context, error, isError: true);
        },
      );
    } else {
      _orderRepository.getOrderBuy(
        widget.proid,
        widget.styleid,
        widget.pronum,
        _orderAffirmBean.address.id,
        widget.shopType,
        _orderAffirmBean.ordermark,
        (data) {
          data.ordertype = "outer";
          String orderInfo = json.encode(data.toJson());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => OrderPayPage(
                orderInfo: orderInfo,
              ),
            ),
            result: true,
          );
        },
        (error) {
          Toast.toast(context, error, isError: true);
        },
      );
    }
  }
}
