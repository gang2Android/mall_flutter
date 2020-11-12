import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/order/OrderRepository.dart';
import 'package:flutter_app_01/ui/order/detail/OrderDetailBean.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/DefaultAppBar.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderNo;

  const OrderDetailPage({Key key, this.orderNo}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  OrderRepository _orderRepository = OrderRepository();
  OrderDetailBean _orderDetailBean;

  @override
  void initState() {
    super.initState();

    _orderRepository.getOrderDetail(
      widget.orderNo,
      (data) {
        _orderDetailBean = data;
        setState(() {});
      },
      (error) {
        Toast.toast(context, error, isError: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("订单详情"),
      body: CustomScrollView(
        slivers: _bodyView(),
      ),
    );
  }

  _bodyView() {
    List<Widget> itemViews = List();

    if (_orderDetailBean == null) {
      return itemViews;
    }

    itemViews.add(_addressView());

    itemViews.add(_tempView());

    itemViews.add(_supView());

    itemViews.add(_tempView());

    itemViews.add(_infoView());

    itemViews.add(_tempView());

    itemViews.add(_exView());

    return itemViews;
  }

  Widget _addressView() {
    String name = "name";
    String mobile = "mobile";
    String addressInfo = "addressInfo";

    if (_orderDetailBean != null) {
      name = _orderDetailBean.receiveName;
      mobile = _orderDetailBean.userTel;
      addressInfo = _orderDetailBean.province +
          _orderDetailBean.city +
          _orderDetailBean.county +
          _orderDetailBean.town +
          _orderDetailBean.address;
    }

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Row(
          children: [
            Icon(Icons.location_on),
            Container(width: 5.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name     $mobile",
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  Text(
                    "$addressInfo",
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tempView() {
    return SliverToBoxAdapter(
      child: Container(height: 5.0),
    );
  }

  Widget _supView() {
    return SliverToBoxAdapter(
      child: _supItemView(),
    );
  }

  _supItemView() {
    List<Widget> items = List();
    items.add(
      Row(
        children: [
          Text(
            "name",
            style: TextStyle(
              fontSize: 16.0,
              color: Color(App.appColor),
            ),
          ),
          Expanded(child: Container()),
          Text(
            "${_orderDetailBean.staname}",
            style: TextStyle(
              fontSize: 18.0,
              color: Color(App.appColor),
            ),
          ),
        ],
      ),
    );

    items.add(Container(height: 5.0));

    _orderDetailBean.voo.forEach(
      (element) {
        items.add(_proItemView(element));
      },
    );
    // items.add(
    //   Row(
    //     children: [
    //       Text(
    //         "下单时间：",
    //         style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
    //       ),
    //       Expanded(child: Container()),
    //       InkWell(
    //         child: Text(
    //           "${_orderDetailBean.addDate}",
    //           style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    // items.add(
    //   Row(
    //     children: [
    //       Text(
    //         "订单号：",
    //         style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
    //       ),
    //       Expanded(child: Container()),
    //       InkWell(
    //         child: Text(
    //           "${_orderDetailBean.outerOrderId}",
    //           style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    items.add(
      Row(
        children: [
          Text(
            "商品总价",
            style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
          ),
          Expanded(child: Container()),
          InkWell(
            child: Text(
              "￥${_orderDetailBean.goodsAmount}",
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
            "运费(快递)",
            style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
          ),
          Expanded(child: Container()),
          InkWell(
            child: Text(
              "￥${_orderDetailBean.freight}",
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
            "订单总价",
            style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
          ),
          Expanded(child: Container()),
          InkWell(
            child: Text(
              "￥${_orderDetailBean.orderAmount}",
              style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
            ),
          ),
        ],
      ),
    );

    var supItemView = Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        children: items,
      ),
    );
    return supItemView;
  }

  Widget _proItemView(OrderDetailProBean element) {
    return InkWell(
      onTap: () {
        App.router.navigateTo(
            context, Routes.proDetailPage + "?proId=${element.proid}");
      },
      child: Row(
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
                  maxLines: 2,
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
      ),
    );
  }

  Widget _infoView() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "交易单号",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                Container(width: 10.0),
                Text(
                  "${_orderDetailBean.outerOrderId}",
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                Container(width: 10.0),
                InkWell(
                  child: Text(
                    "复制",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(App.appColor),
                    ),
                  ),
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(
                          text: "订单号：${_orderDetailBean.outerOrderId}"),
                    );
                    Toast.toast(context, "已复制到剪贴板");
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "交易时间",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                Container(width: 10.0),
                Text(
                  "${_orderDetailBean.addDate}",
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "订单溯源",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                Container(width: 10.0),
                InkWell(
                  child: Text(
                    "点击查看详情",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  onTap: () {
                    Toast.toast(context, "${_orderDetailBean.block_hash}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _exView() {
    return SliverToBoxAdapter(
      child: Container(
        child: Text("_exView"),
      ),
    );
  }

  /// **************************************************************************

}
