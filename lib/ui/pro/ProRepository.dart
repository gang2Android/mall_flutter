import 'dart:convert';

import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/pro/det/ProDetailBean.dart';
import 'package:flutter_app_01/ui/pro/list/ProListBean.dart';
import 'package:flutter_app_01/utils/RequestUtils.dart';

class ProRepository {
  getProList(
    Function success,
    Function error, {
    int page: 1,
    String key: "",
    int sort: 1,
    String shop_type: "",
    String cid: "",
    String cidtwo: "",
    String cidthree: "",
  }) async {
    String url = App.DOMAIN_API + "service-goods/goods/searchProduct";
    Map<String, dynamic> result =
        await RequestUtils.getInstance().postOfAwait(url, params: {
      "page": page,
      "keyword": key,
      "sort": sort,
      "shop_type": shop_type,
      "cid": cid,
      "cidtwo": cidtwo,
      "cidthree": cidthree,
    });
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      ProListBean proListBean = ProListBean.fromJson(result);
      if (proListBean.data_list.length == 0) {
        error("data empty");
        return;
      }
      success(proListBean.data_list);
    } catch (e) {
      error(e.toString());
    }
  }

  getProDetail(String proId, Function success, Function error) async {
    // proId = "37829";
    String url = App.DOMAIN_API + "item-web/item/detail?proid=$proId";
    Map<String, dynamic> result =
        await RequestUtils.getInstance().getOfAwait(url, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      ProDetailBean proDetailBean = ProDetailBean.fromJson(result);
      success(proDetailBean);
    } catch (e) {
      error(e.toString());
    }
  }

  void addCart(String proid, String styleid, int num, String address,
      Function(String) success, Function(String) error) async {
    String url = App.DOMAIN_API + "cart-web/cart/addCart";
    Map<String, dynamic> result =
        await RequestUtils.getInstance().postOfAwait(url,
            params: {
              "proid": proid,
              "styleid": styleid,
              "pronum": num,
              "address": address,
            },
            successStatus: "0",
            isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    try {
      success(result["hint"]);
    } catch (e) {
      error(e.toString());
    }
  }

  void addCollect(
      String proid, Function(String) success, Function(String) error) async {
    String url =
        App.DOMAIN_API + "item-web/item/addCollection?id=$proid&collectType=1";
    Map<String, dynamic> result =
        await RequestUtils.getInstance().getOfAwait(url, isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    try {
      success(result["hint"]);
    } catch (e) {
      error(e.toString());
    }
  }
}
