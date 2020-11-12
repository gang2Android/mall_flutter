import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/cart/CartBean.dart';
import 'package:flutter_app_01/utils/RequestUtils.dart';

class CartRepository {
  getCartList(int shopType, int page, Function success, Function error) async {
    String url = App.DOMAIN_API +
        "cart-web/cart/cartList?shop_type=$shopType&page=$page";
    Map<String, dynamic> result = await RequestUtils.getInstance()
        .getOfAwait(url, successStatus: "0", isLogin: true);
    if (result.containsKey("msg")) {
      error(result["msg"]);
      return;
    }
    result = result["data"];
    try {
      CartBean cartBean = CartBean.fromJson(result);
      success(cartBean);
    } catch (e) {
      error(e.toString());
    }
  }
}
