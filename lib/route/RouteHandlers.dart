import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/address/det/AddressDetailPage.dart';
import 'package:flutter_app_01/ui/address/list/AddressListPage.dart';
import 'package:flutter_app_01/ui/order/affirm/OrderAffirmPage.dart';
import 'package:flutter_app_01/ui/order/detail/OrderDetailPage.dart';
import 'package:flutter_app_01/ui/order/list/OrderListPage.dart';
import 'package:flutter_app_01/ui/order/pay/OrderPayPage.dart';
import 'package:flutter_app_01/ui/other/AboutPage.dart';
import 'package:flutter_app_01/ui/other/H5Page.dart';
import 'package:flutter_app_01/ui/other/SetPage.dart';
import 'package:flutter_app_01/ui/pro/det/ProDetailPage.dart';
import 'package:flutter_app_01/ui/pro/list/ProListPage.dart';
import 'package:flutter_app_01/ui/search/SearchPage.dart';
import 'package:flutter_app_01/ui/user/UserLoginPage.dart';
import 'package:flutter_app_01/ui/user/UserSharePage.dart';
import 'package:flutter_app_01/ui/user/collect/CollectListPage.dart';

Handler h5PageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String data = params['data'].first;

  var jsonMap = json.decode(data);
  String title = jsonMap["ArticleTitle"];
  String content = jsonMap["ArticleContent"];
  return H5Page(data: content, title: title);
});

Handler setPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SetPage();
});

Handler aboutPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutPage();
});

Handler searchPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchPage();
});

Handler proListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String key = "";
  String cid = "";
  String shop_type = "";
  if (params.containsKey("key")) {
    key = params['key'].first;
  }
  if (params.containsKey("cid")) {
    cid = params['cid'].first;
  }
  if (params.containsKey("shop_type")) {
    shop_type = params['shop_type'].first;
  }
  return ProListPage(keyStr: key, cid: cid, shop_type: shop_type);
});

Handler proDetailPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String proId = params['proId'].first;
  return ProDetailPage(proId: proId);
});

Handler orderAffirmPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  String cartIds = "";
  String shopType = "";
  bool isCart = true;
  String proId = "";
  String styleId = "";
  String proNum = "";
  String addressId = "";
  if (params.containsKey("isCart")) {
    isCart = false;
    shopType = params['shopType'].first;
    proId = params['proId'].first;
    styleId = params['styleId'].first;
    proNum = params['proNum'].first;
    addressId = params['addressId'].first;
  } else {
    isCart = true;
    cartIds = params['cartIds'].first;
    shopType = params['shopType'].first;
  }
  return OrderAffirmPage(
    cartIds: cartIds,
    shopType: shopType,
    isCart: isCart,
    proid: proId,
    styleid: styleId,
    pronum: proNum,
    addressId: addressId,
  );
});

Handler orderPayPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  String info = params['info'].first;
  return OrderPayPage(orderInfo: info);
});

Handler orderListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  int index = int.parse(params["index"].first.toString());
  return OrderListPage(index: index);
});

Handler orderDetailPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  String orderNo = params["orderNo"].first.toString();
  return OrderDetailPage(orderNo: orderNo);
});

Handler addressListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  return AddressListPage();
});

Handler addressDetailPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  bool isAdd = params["isAdd"].first.toString() == "true";
  String info = "";
  if (params.containsKey("info")) {
    info = params["info"].first.toString();
  }
  return AddressDetailPage(isAdd: isAdd, addressInfo: info);
});

Handler collectListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  return CollectListPage();
});

Handler userSharePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (App.token.isEmpty) {
    return UserLoginPage();
  }
  return UserSharePage();
});

Handler userLoginPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserLoginPage();
});
