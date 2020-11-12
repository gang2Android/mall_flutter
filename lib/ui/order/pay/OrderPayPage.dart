import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/order/OrderInfoBean.dart';
import 'package:flutter_app_01/ui/order/OrderRepository.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/keyboard/CustomKeyboard.dart';

class OrderPayPage extends StatefulWidget {
  final String orderInfo;

  OrderPayPage({Key key, this.orderInfo}) : super(key: key);

  @override
  _OrderPayPageState createState() => _OrderPayPageState();
}

class _OrderPayPageState extends State<OrderPayPage> {
  OrderRepository _orderRepository = OrderRepository();
  OrderInfoBean _orderInfoBean;

  int _payType = 1;

  @override
  void initState() {
    super.initState();
    // String jsonStr = '{"ordersn": "1310869280006184960", "orderamount": "1368.00", "yufei": "0.00"}';
    // var map = json.decode(jsonStr);
    var map = json.decode(widget.orderInfo);
    _orderInfoBean = OrderInfoBean.fromJson(map);
    print(_orderInfoBean);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("订单支付"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "订单号：${_orderInfoBean.ordersn}",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            Text(
              "运费：${_orderInfoBean.yufei}",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            Text(
              "订单金额：${_orderInfoBean.orderamount}",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            Container(height: 10.0),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child:
                  Text(
                    "选择支付方式：",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  // ),
                  CheckboxListTile(
                    title: Text("余额"),
                    subtitle: Text("备注"),
                    value: _payType == 1,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        this._payType = 1;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("支付宝"),
                    subtitle: Text("备注"),
                    value: _payType == 2,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        this._payType = 2;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("微信"),
                    subtitle: Text("备注"),
                    value: _payType == 3,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        this._payType = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(App.appColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "立即支付",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
                onTap: () {
                  _startPay();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startPay() {
    switch (_payType) {
      case 1:
        _balancePay();
        break;
      case 2:
        _aliPay();
        break;
      case 3:
        _wxPay();
        break;
    }
  }

  void _balancePay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return CustomKeyboard(
          keyHeight: 46,
          autoBack: false,
          pwdLength: 6,
          onKeyDown: (keyEvent) {
            if (keyEvent.isClose()) {
              Navigator.pop(context);
            }
            debugPrint(keyEvent.key);
          },
          onResult: (data) {
            Navigator.pop(context);
            Toast.toast(context, "密码$data");
            _orderRepository.orderBalancePay(
              data,
              _orderInfoBean.ordersn,
              _orderInfoBean.ordertype,
              (data) {},
              (error) {
                Toast.toast(context, error, isError: true);
              },
            );
          },
        );
      },
    );
  }

  void _aliPay() {
    _orderRepository.orderAliPay(
      _orderInfoBean.ordersn,
      _orderInfoBean.orderamount,
      _orderInfoBean.ordertype,
      (data) {
        Map<String, String> map = Map();
        map["ArticleTitle"] = "支付宝支付";
        if (data.contains("display:none")) {
          data = data.replaceAll("display:none", "display:block");
        }
        map["ArticleContent"] = "<span>123123</span>" + data;
        String str = json.encode(map);
        App.router.navigateTo(
            context, Routes.h5Page + "?data=${Uri.encodeComponent(str)}");
      },
      (error) {
        Toast.toast(context, error, isError: true);
      },
    );
  }

  void _wxPay() {
    Toast.toast(context, "微信支付", isError: true);
  }
}
