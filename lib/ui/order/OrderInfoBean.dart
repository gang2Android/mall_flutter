class OrderInfoBean {
  String ordersn;
  String orderamount;
  String yufei;
  String ordertype;

  OrderInfoBean(this.ordersn, this.orderamount, this.yufei, this.ordertype);

  OrderInfoBean.fromJson(Map<String, dynamic> json) {
    if (json.toString().length < 5) throw Exception("数据有误");

    ordersn = json["ordersn"];
    orderamount = json["orderamount"];
    yufei = json["yufei"];
    ordertype = json["ordertype"];
  }

  Map<String, dynamic> toJson() => {
        "ordersn": ordersn,
        "orderamount": orderamount,
        "yufei": yufei,
        "ordertype": ordertype,
      };

  @override
  String toString() {
    return 'OrderInfoBean{ordersn: $ordersn, orderamount: $orderamount, yufei: $yufei}';
  }
}
