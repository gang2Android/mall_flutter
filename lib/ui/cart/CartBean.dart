import 'package:flutter_app_01/widget/SingleChooseWidget.dart';

class CartBean {
  List<CartSupBean> data_list;

  CartBean.fromJson(Map<String, dynamic> json) {
    data_list = List<CartSupBean>();
    json['data_list'].forEach((v) {
      data_list.add(CartSupBean.fromJson(v));
    });
  }

  @override
  String toString() {
    return 'CartBean{data_list: $data_list}';
  }
}

class CartSupBean {
  String supid;
  String supname;
  List<CartSupProBean> sub;

  bool isCheck = false;

  CartSupBean(this.supid, this.supname, this.sub);

  CartSupBean.fromJson(Map<String, dynamic> json) {
    supid = json["supid"].toString();
    supname = json["supname"].toString();
    sub = List<CartSupProBean>();
    json['sub'].forEach((v) {
      sub.add(CartSupProBean.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() => {
        "supid": supid,
        "supname": supname,
        "sub": sub,
      };

  @override
  String toString() {
    return 'CartSupBean{supid: $supid, supname: $supname, sub: $sub, isCheck: $isCheck}';
  }
}

class CartSupProBean {
  String id;
  String proid;
  String proimg;
  String proname;
  int pronum;
  String shopprice;
  String stylename;

  String isonsell;
  String status;

  bool isCheck = false;

  String fright_base = "8.00";
  String fright_once = "8.00";

  CartSupProBean(this.id, this.proid, this.proimg, this.proname, this.pronum,
      this.shopprice, this.stylename, this.isonsell, this.status);

  factory CartSupProBean.fromJson(Map<String, dynamic> json) => CartSupProBean(
        json["id"],
        json["proid"],
        json["proimg"],
        json["proname"],
        int.parse(json["pronum"].toString()),
        json["shopprice"].toString(),
        json["stylename"],
        json["isonsell"],
        json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "proid": proid,
        "proimg": proimg,
        "proname": proname,
        "pronum": pronum,
        "shopprice": shopprice,
        "stylename": stylename,
        "isonsell": isonsell,
        "status": status,
      };

  @override
  String toString() {
    return 'CartSupProBean{id: $id, proid: $proid, proimg: $proimg, proname: $proname, pronum: $pronum, shopprice: $shopprice, stylename: $stylename, isonsell: $isonsell, status: $status, isCheck: $isCheck}';
  }
}

class CartTopBean implements ChooseBean {
  String id;
  String name;

  CartTopBean(this.id, this.name);

  @override
  String getId() => this.id;

  @override
  String getName() => this.name;

  @override
  String toString() {
    return 'CartTopBean{id: $id, name: $name}';
  }
}
