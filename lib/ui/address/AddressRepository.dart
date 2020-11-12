import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/address/AddressBean.dart';
import 'package:flutter_app_01/utils/RequestUtils.dart';

class AddressRepository {
  void getAddressList(int page, Function(List<AddressBean>) success,
      Function(String) error) async {
    String url = App.DOMAIN_API + "service-user/address/list";
    Map<String, dynamic> data =
        await RequestUtils.getInstance().getOfAwait(url, isLogin: true);
    if (data.containsKey("msg")) {
      error(data["msg"]);
      return;
    }
    data = data["data"];
    try {
      // var dataList = data["addresslist"];
      List<AddressBean> dataList = List();
      data['addresslist'].forEach((v) {
        dataList.add(AddressBean.fromJson(v));
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

  void delAddressItem(
    String id,
    Function(String) success,
    Function(String) error,
  ) async {
    String url =
        App.DOMAIN_API + "service-user/address/remove?id=$id&type=del_default";
    Map<String, dynamic> data =
        await RequestUtils.getInstance().getOfAwait(url, isLogin: true);
    if (data.containsKey("msg")) {
      error(data["msg"]);
      return;
    }
    try {
      success(data["hint"]);
    } catch (e) {
      error(e.toString());
    }
  }

  void addAddress(AddressBean addressBean, Function(String) success,
      Function(String) error) async {
    String url = App.DOMAIN_API + "service-user/address/add";
    var params = {
      "receiveName": addressBean.receiveName,
      "receivename": addressBean.receiveName,
      "mobile": addressBean.mobile,
      "province": addressBean.province,
      "city": addressBean.city,
      "county": addressBean.county,
      "town": addressBean.town,
      "address": addressBean.address,
      "isDefault": addressBean.isDefault,
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
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

  void updateAddress(AddressBean addressBean, Function(String) success,
      Function(String) error) async {
    String url = App.DOMAIN_API + "service-user/address/editSave";
    var params = {
      "id": addressBean.id,
      "userId": addressBean.userId,
      "receiveName": addressBean.receiveName,
      "receivename": addressBean.receiveName,
      "mobile": addressBean.mobile,
      "province": addressBean.province,
      "city": addressBean.city,
      "county": addressBean.county,
      "town": addressBean.town,
      "address": addressBean.address,
      "isDefault": addressBean.isDefault,
    };

    Map<String, dynamic> result = await RequestUtils.getInstance()
        .postOfAwait(url, params: params, isLogin: true);
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
