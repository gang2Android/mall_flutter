class OrderListBean {
  String supplierid;
  String supname;

  String status;
  String staname;

  String outerOrderId;
  String innerorderid;

  String freight;
  String goodsamount;
  String orderamount;

  String shop_type;

  String adddate;

  List<OrderListProBean> voo;

  OrderListBean.fromJson(Map<String, dynamic> json){
    supplierid = json["supplierid"].toString();
    supname = json["supname"];
    status = json["status"].toString();
    staname = json["staname"];
    outerOrderId = json["outerOrderId"];
    innerorderid = json["innerorderid"];
    freight = json["freight"].toString();
    goodsamount = json["goodsamount"].toString();
    orderamount = json["orderamount"].toString();
    shop_type = json["shop_type"].toString();
    adddate = json["adddate"];
    voo = List<OrderListProBean>();
    json['voo'].forEach((v) {
      voo.add(OrderListProBean.fromJson(v));
    });
  }

  @override
  String toString() {
    return 'OrderListBean{supplierid: $supplierid, supname: $supname, status: $status, staname: $staname, outerOrderId: $outerOrderId, innerorderid: $innerorderid, freight: $freight, goodsamount: $goodsamount, orderamount: $orderamount, shop_type: $shop_type, adddate: $adddate, voo: $voo}';
  }
}

class OrderListProBean {
  String proid;
  String proname;
  String img;
  String spec_img;
  String stylename;
  String pronum;
  String price;
  String vipPrice;

  OrderListProBean(this.proid, this.proname, this.img, this.spec_img,
      this.stylename, this.pronum, this.price, this.vipPrice);

  factory OrderListProBean.fromJson(Map<String, dynamic> json) =>
      OrderListProBean(
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
    return 'OrderListProBean{proid: $proid, proname: $proname, img: $img, spec_img: $spec_img, stylename: $stylename, pronum: $pronum, price: $price, vipPrice: $vipPrice}';
  }
}
