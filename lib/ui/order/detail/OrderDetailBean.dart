import 'package:common_utils/common_utils.dart';

class OrderDetailBean {
  String receiveName;
  String userTel;
  String province;
  String city;
  String county;
  String town;
  String address;

  String status;
  String staname;

  String goodsAmount;
  String freight;
  String orderAmount;

  String addDate;
  String block_hash;
  String outerOrderId;

  List<OrderDetailProBean> voo;

  OrderDetailBean.fromJson(Map<String, dynamic> json) {
    receiveName = json["receiveName"];
    userTel = json["userTel"];
    province = json["province"];
    city = json["city"];
    county = json["county"];
    town = json["town"];
    address = json["address"];
    status = json["status"].toString();
    staname = json["staname"];

    goodsAmount = json["goodsAmount"].toString();
    freight = json["freight"].toString();
    orderAmount = json["orderAmount"].toString();

    // addDate = json["adddate"];
    addDate = DateUtil.formatDateMs(json["addDate"], format: "yyyy/M/d HH:mm:ss");
    block_hash = json["block_hash"];
    outerOrderId = json["outerOrderId"];

    voo = List<OrderDetailProBean>();
    json['vvo'].forEach((v) {
      voo.add(OrderDetailProBean.fromJson(v));
    });
  }

  @override
  String toString() {
    return 'OrderDetailBean{receiveName: $receiveName, userTel: $userTel, province: $province, city: $city, county: $county, town: $town, address: $address, status: $status, staname: $staname, addDate: $addDate, block_hash: $block_hash, outerOrderId: $outerOrderId, voo: $voo}';
  }
}

class OrderDetailProBean {
  String proid;
  String proname;
  String img;
  String spec_img;
  String stylename;
  String pronum;
  String price;
  String vipPrice;

  OrderDetailProBean(this.proid, this.proname, this.img, this.spec_img,
      this.stylename, this.pronum, this.price, this.vipPrice);

  factory OrderDetailProBean.fromJson(Map<String, dynamic> json) =>
      OrderDetailProBean(
        json["proid"].toString(),
        json["proname"],
        json["img"],
        json["spec_img"],
        json["stylename"],
        json["pronum"].toString(),
        json["price"].toString(),
        json["vipPrice"].toString(),
      );

  @override
  String toString() {
    return 'OrderDetailProBean{proid: $proid, proname: $proname, img: $img, spec_img: $spec_img, stylename: $stylename, pronum: $pronum, price: $price, vipPrice: $vipPrice}';
  }
}
