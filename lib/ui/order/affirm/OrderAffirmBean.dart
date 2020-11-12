class OrderAffirmBean {
  String viptotal;
  String zero_fright;

  OrderAffirmAddressBean address;
  List<OrderAffirmSupBean> groupcart;

  String ordermark;

  OrderAffirmBean.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("viptotal")) {
      viptotal = json["viptotal"];
    } else {
      viptotal = json["pricetotal"];
    }
    zero_fright = json["zero_fright"];
    address = OrderAffirmAddressBean.fromJson(json["relist"]);
    groupcart = List<OrderAffirmSupBean>();
    json['groupcart'].forEach((v) {
      groupcart.add(OrderAffirmSupBean.fromJson(v));
    });

    ordermark = json["ordermark"];
  }

  @override
  String toString() {
    return 'OrderAffirmBean{address: $address}';
  }
}

class OrderAffirmAddressBean {
  String id;
  String name;
  String mobile;
  String addressInfo;

  OrderAffirmAddressBean(this.id, this.name, this.mobile, this.addressInfo);

  factory OrderAffirmAddressBean.fromJson(Map<String, dynamic> json) =>
      OrderAffirmAddressBean(
        json["Id"].toString(),
        json["ReceiveName"],
        json["Mobile"],
        json["Province"] +
            json["City"] +
            json["County"] +
            json["town"] +
            json["Address"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "mobile": mobile,
  //       "addressInfo": addressInfo,
  //     };

  @override
  String toString() {
    return 'OrderAffirmAddressBean{id: $id, name: $name, mobile: $mobile, addressInfo: $addressInfo}';
  }
}

class OrderAffirmSupBean {
  String supid;
  String supname;

  String pronum;
  String fregiht;
  String viptotal;

  List<OrderAffirmSupProBean> voo;

  OrderAffirmSupBean(this.supid, this.supname, this.pronum, this.fregiht,
      this.viptotal, this.voo);

  OrderAffirmSupBean.fromJson(Map<String, dynamic> json) {
    supid = json["relist"].toString();
    supname = json["supname"].toString();
    pronum = json["pronum"].toString();
    fregiht = json["fregiht"].toString();
    if (json.containsKey("viptotal")) {
      viptotal = json["viptotal"].toString();
    } else {
      viptotal = json["sspp"].toString();
    }

    voo = List<OrderAffirmSupProBean>();
    json['voo'].forEach((v) {
      voo.add(OrderAffirmSupProBean.fromJson(v));
    });
  }

  @override
  String toString() {
    return 'OrderSupBean{supid: $supid, supname: $supname, pronum: $pronum, fregiht: $fregiht, viptotal: $viptotal, voo: $voo}';
  }
}

class OrderAffirmSupProBean {
  String proid;
  String img;
  String proname;
  String stylename;
  String pronum;
  String shopprice;

  OrderAffirmSupProBean(this.proid, this.img, this.proname, this.stylename,
      this.pronum, this.shopprice);

  factory OrderAffirmSupProBean.fromJson(Map<String, dynamic> json) =>
      OrderAffirmSupProBean(
        json["proid"].toString(),
        json["img"],
        json["proname"],
        json["stylename"],
        json["pronum"],
        json["shopprice"],
      );

  // Map<String, dynamic> toJson() => {
  //       "proid": proid,
  //       "img": img,
  //       "proname": proname,
  //       "stylename": stylename,
  //       "pronum": pronum,
  //       "shopprice": shopprice,
  //     };

  @override
  String toString() {
    return 'OrderSupProBean{proid: $proid, img: $img, proname: $proname, stylename: $stylename, pronum: $pronum, shopprice: $shopprice}';
  }
}
