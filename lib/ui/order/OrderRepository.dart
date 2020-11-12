import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/order/OrderInfoBean.dart';
import 'package:flutter_app_01/ui/order/affirm/OrderAffirmBean.dart';
import 'package:flutter_app_01/ui/order/detail/OrderDetailBean.dart';
import 'package:flutter_app_01/ui/order/list/OrderListBean.dart';
import 'package:flutter_app_01/utils/RequestUtils.dart';

class OrderRepository {
  getAffirmInfo(
      String cartIds, String shopType, Function success, Function error) async {
    String url = App.DOMAIN_API + "cart-web/cart/affirm";

    var params = {
      "shop_type": shopType,
      "id": cartIds,
      "addressId": "",
      "discount": "10",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    if (result["data"] == null) {
      error(result["hint"]);
      return;
    }
    result = result["data"];
    try {
      OrderAffirmBean orderAffirmBean = OrderAffirmBean.fromJson(result);
      success(orderAffirmBean);
    } catch (e) {
      error(e.toString());
    }
  }

  getAffirmInfoBuy(String proid, String styleid, String pronum,
      String addressId, Function success, Function error) async {
    String url = App.DOMAIN_API + "item-web/buy/nowBuy";

    var params = {
      "proid": proid,
      "styleid": styleid,
      "pronum": pronum,
      "addressId": addressId,
      "discount": "10",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    if (result["data"] == null) {
      error(result["hint"]);
      return;
    }
    result = result["data"];
    try {
      OrderAffirmBean orderAffirmBean = OrderAffirmBean.fromJson(result);
      success(orderAffirmBean);
    } catch (e) {
      error(e.toString());
    }
  }

  getOrderInfo(String cartIds, String addressId, String ordermark,
      Function(OrderInfoBean infoBean) success, Function error) async {
    String url = App.DOMAIN_API + "order-web/order/generateCart";
    var params = {
      "shop_type": "2",
      "id": cartIds,
      "addres": addressId,
      "ordermark": ordermark,
      "shipping_type": "1",
      "bonus_1": "",
      "paytype": "3",
      "discount": "10",
      "isZero": "0",
      "remarks_1": "1",
      "remarks_57": "11",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      OrderInfoBean orderInfoBean = OrderInfoBean.fromJson(result);
      success(orderInfoBean);
    } catch (e) {
      error(e.toString());
    }
  }

  getOrderList(int page, String shop_type, int index,
      Function(List<OrderListBean>) success, Function(String) error) async {
    String url = App.DOMAIN_API + "service-user/shiro/order/list";
    var params = {
      "pageSize": "20",
      "page": "$page",
      "shoptype": shop_type,
      "orderIx": "$index",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      List<OrderListBean> orderListBean = List();
      result['list'].forEach((v) {
        orderListBean.add(OrderListBean.fromJson(v));
      });
      if (orderListBean.isEmpty) {
        error("没有数据了");
      } else {
        success(orderListBean);
      }
    } catch (e) {
      error(e.toString());
    }
  }

  void getOrderDetail(String orderNo, Function(OrderDetailBean) success,
      Function(String) error) async {
    String url = App.DOMAIN_API + "service-user/shiro/findOrderDetailInfo";
    var params = {
      "innerOrderId": orderNo,
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      OrderDetailBean orderDetailBean = OrderDetailBean.fromJson(result);
      success(orderDetailBean);
    } catch (e) {
      error(e.toString());
    }
  }

  getOrder(String addressId, String cartIds, String ordermark,
      Function(OrderInfoBean) success, Function(String) error) async {
    String url = App.DOMAIN_API + "order-web/order/generateCart";
    var params = {
      "addres": addressId,
      "shop_type": "2",
      "id": cartIds,
      "ordermark": ordermark,
      "paytype": "3",
      "discount": "10",
      "isZero": "0",
      "remarks_57": "11",
      "shipping_type": "1",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      OrderInfoBean orderPayBean = OrderInfoBean.fromJson(result);
      success(orderPayBean);
    } catch (e) {
      print(e.toString());
      error(e.toString());
    }
  }

  getOrderBuy(
      String proid,
      String styleid,
      String pronum,
      String addressId,
      String shop_type,
      String ordermark,
      Function(OrderInfoBean) success,
      Function(String) error) async {
    String url = App.DOMAIN_API + "order-web/order/generatenow";
    var params = {
      "proid": proid,
      "styleid": styleid,
      "pronum": pronum,
      "addres": addressId,
      // "shipping_method": "shipping_method",
      // "remarks_1": "1",
      "ordermark": ordermark,
      "shop_type": shop_type,
      "paytype": "3",
      "discount": "10",
      "isZero": "0",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true, successStatus: "0");
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      OrderInfoBean orderPayBean = OrderInfoBean.fromJson(result);
      success(orderPayBean);
    } catch (e) {
      print(e.toString());
      error(e.toString());
    }
  }

  orderBalancePay(String pwd, String orderSn, String orderType,
      Function(String) success, Function(String) error) async {
    String url = App.DOMAIN_API + "order-web/pay/orderPay";
    var params = {
      "LevIIPwd": pwd,
      "orderno": orderSn,
      "ordertype": orderType,
      "type": "",
      "paytype": "2",
      "beans": "2",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true, successStatus: "0");
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    try {
      success(result["hint"]);
    } catch (e) {
      print(e.toString());
      error(e.toString());
    }
  }

  orderAliPay(String ordersn, String totalAmount, String orderType,
      Function(String) success, Function(String) error) async {
    String url = App.DOMAIN_API + "order-web/pay/alipay";
    var params = {
      "outTradeNo": ordersn,
      "totalAmount": totalAmount,
      "ordertype": orderType,
      "paytype": "2",
      "body": ordersn,
      "subject": ordersn,
      "isZero": "0",
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true, successStatus: "1");
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    try {
      success(result["data"]);
    } catch (e) {
      print(e.toString());
      error(e.toString());
    }
  }
}
