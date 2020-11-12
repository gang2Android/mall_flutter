import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/me/MeBean.dart';
import 'package:flutter_app_01/ui/user/collect/CollectBean.dart';
import 'package:flutter_app_01/utils/RequestUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  userLogin(
      String name, String pwd, Function success, Function(String) error) async {
    String url = App.DOMAIN_API + "service-sso/shiro/user/login/check";
    var params = {
      "username": name,
      "password": pwd,
    };
    SharedPreferences sp = await SharedPreferences.getInstance();
    Map<String, dynamic> result =
        await RequestUtils.getInstance().postOfAwait(url, params: params);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      String token = result["token"];
      String memToken = result["mem_token"];
      sp.setString("token", token);
      sp.setString("memToken", memToken);
      App.token = token;
      App.token_mem = memToken;

      success();
    } catch (e) {
      error(e.toString());
    }
  }

  void getUserInfo(Function success, Function(String) error) async {
    String url = App.DOMAIN_MEM + "app.php/member/userinfo";
    Map<String, dynamic> result = await RequestUtils.getInstance()
        .getOfAwait(url, successStatus: "0", isLogin: true);
    if (result.containsKey("msg")) {
      if (result["msg"].toString().contains("登录")) {
        App.token_mem = "";
        App.token = "";
      } else {
        error(result["msg"]);
      }
      return;
    }
    result = result["data"];
    try {
      MeBean meBean = MeBean.fromJson(result);
      success(meBean);
    } catch (e) {
      error(e.toString());
    }
  }

  void getCollectList(int page, Function(List<CollectBean>) success,
      Function(String) error) async {
    String url = App.DOMAIN_API + "item-web/item/collectionList?page=$page";
    Map<String, dynamic> result = await RequestUtils.getInstance()
        .getOfAwait(url, successStatus: "0", isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    try {
      List<CollectBean> dataList = List();
      result['data'].forEach((v) {
        dataList.add(CollectBean.fromJson(v));
      });
      if (dataList.isEmpty) {
        error("数据为空");
      } else {
        success(dataList);
      }
    } catch (e) {
      error(e.toString());
    }
  }

  void delCollect(String id, Function(String) success,
      Function(String) error) async {
    String url = App.DOMAIN_API + "item-web/item/deleteCollectionbyId?ids=$id";
    Map<String, dynamic> result = await RequestUtils.getInstance()
        .getOfAwait(url, successStatus: "0", isLogin: true);
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
