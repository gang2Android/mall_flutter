import 'package:flutter_app_01/widget/SingleChooseWidget.dart';

class ProDetailBean {
  List<ProEvaluationBean> evaluation;
  List<String> imgalbum;
  ProDetailInfoBean datails;
  ProStoreInfoBean supPage;
  ProSpecBean guige;

  bool isCollect = false;

  ProDetailBean(
      this.imgalbum, this.datails, this.supPage, this.guige, this.isCollect);

  ProDetailBean.fromJson(Map<String, dynamic> json) {
    evaluation = List<ProEvaluationBean>();
    json['evaluation'].forEach((v) {
      evaluation.add(ProEvaluationBean.fromJson(v));
    });

    imgalbum = List<String>();
    json['imgalbum'].forEach((v) {
      imgalbum.add(v.toString());
    });
    datails = ProDetailInfoBean.fromJson(json["datails"]);
    supPage = ProStoreInfoBean.fromJson(json["supPage"]);
    guige = ProSpecBean.fromJson(json["guige"]);
    isCollect = json["collec"].toString() == "1";
  }

  Map<String, dynamic> toJson() => {
        "imgalbum": imgalbum,
        "datails": datails,
        "supPage": supPage,
        "guige": guige,
        "isCollect": isCollect,
      };

  @override
  String toString() {
    return 'ProDetailBean{evaluation: $evaluation, imgalbum: $imgalbum, datails: $datails, supPage: $supPage, guige: $guige, isCollect: $isCollect}';
  }
}

class ProEvaluationBean {
  String id;
  String userId;
  String userName;
  String userImg;

  String specName;
  String level;
  String content;

  String time;
  String zanNum;

  ProEvaluationBean(this.id, this.userId, this.userName, this.userImg,
      this.specName, this.level, this.content, this.time, this.zanNum);

  factory ProEvaluationBean.fromJson(Map<String, dynamic> json) =>
      ProEvaluationBean(
        json["id"].toString(),
        json["userId"].toString(),
        json["userName"],
        json["userImg"],
        json["specName"],
        json["level"].toString(),
        json["content"],
        json["time"],
        json["zanNum"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "userImg": userImg,
        "specName": specName,
        "level": level,
        "content": content,
        "time": time,
        "zanNum": zanNum,
      };

  @override
  String toString() {
    return 'ProEvaluationBean{id: $id, userId: $userId, userName: $userName, userImg: $userImg, specName: $specName, level: $level, content: $content, time: $time, zanNum: $zanNum}';
  }
}

class ProDetailInfoBean {
  String proid;
  String proname;
  String marketprice;
  String vipprice;
  String description;

  String shop_type;
  String pro_block_hash;

  ProDetailInfoBean(this.proid, this.proname, this.marketprice, this.vipprice,
      this.description, this.shop_type, this.pro_block_hash);

  factory ProDetailInfoBean.fromJson(Map<String, dynamic> json) =>
      ProDetailInfoBean(
        json["proid"].toString(),
        json["proname"],
        json["marketprice"].toString(),
        json["vipprice"].toString(),
        json["description"],
        json["shop_type"].toString(),
        json["pro_block_hash"],
      );

  Map<String, dynamic> toJson() => {
        "proid": proid,
        "proname": proname,
        "vipprice": vipprice,
        "marketprice": marketprice,
        "description": description,
        "shop_type": shop_type,
        "pro_block_hash": pro_block_hash,
      };

  @override
  String toString() {
    return 'ProDetailInfoBean{proid: $proid, proname: $proname, marketprice: $marketprice, vipprice: $vipprice, description: $description, shop_type: $shop_type, pro_block_hash: $pro_block_hash}';
  }
}

class ProStoreInfoBean {
  String id;
  String name;
  String supplierLogo;

  ProStoreInfoBean(this.id, this.name, this.supplierLogo);

  factory ProStoreInfoBean.fromJson(Map<String, dynamic> json) =>
      ProStoreInfoBean(
        json["id"].toString(),
        json["name"],
        json["supplierLogo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "supplierLogo": supplierLogo,
      };

  @override
  String toString() {
    return 'ProStoreInfoBean{id: $id, name: $name, supplierLogo: $supplierLogo}';
  }
}

class ProSpecBean {
  List<ProSpecNameBean> stockname;
  List<ProSpecAttrPathBean> attr_path;
  Map<String, dynamic> attr;

  ProSpecBean(this.stockname, this.attr_path, this.attr);

  ProSpecBean.fromJson(Map<String, dynamic> json) {
    stockname = List<ProSpecNameBean>();
    json['stockname'].forEach((v) {
      stockname.add(ProSpecNameBean.fromJson(v));
    });

    attr_path = List<ProSpecAttrPathBean>();
    json['attr_path'].forEach((v) {
      attr_path.add(ProSpecAttrPathBean.fromJson(v));
    });

    attr = json["attr"];
  }

  Map<String, dynamic> toJson() => {
        "stockname": stockname,
        "attr_path": attr_path,
        "attr": attr,
      };

  @override
  String toString() {
    return 'ProSpecBean{stockname: $stockname, attr_path: $attr_path, attr: $attr}';
  }
}

class ProSpecNameBean {
  String id;
  String proid;
  String name;

  ProSpecNameBean(this.id, this.proid, this.name);

  factory ProSpecNameBean.fromJson(Map<String, dynamic> json) =>
      ProSpecNameBean(
        json["id"].toString(),
        json["proid"].toString(),
        json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "proid": proid,
        "name": name,
      };

  @override
  String toString() {
    return 'ProSpecNameBean{id: $id, proid: $proid, name: $name}';
  }
}

class ProSpecAttrPathBean {
  String styleid;
  String attr_path;
  String kucun;
  String price;
  String wholesale_price;
  String lf;

  String name = "";
  int num = 1;
  bool isClose = true;
  String address = "";

  ProSpecAttrPathBean(this.styleid, this.attr_path, this.kucun, this.price,
      this.wholesale_price, this.lf);

  factory ProSpecAttrPathBean.fromJson(Map<String, dynamic> json) =>
      ProSpecAttrPathBean(
        json["styleid"],
        json["attr_path"],
        json["kucun"],
        json["price"].toString(),
        json["wholesale_price"].toString(),
        json["lf"],
      );

  Map<String, dynamic> toJson() => {
        "styleid": styleid,
        "attr_path": attr_path,
        "kucun": kucun,
        "price": price,
        "wholesale_price": wholesale_price,
        "lf": lf,
      };

  @override
  String toString() {
    return 'ProSpecAttrPathBean{styleid: $styleid, attr_path: $attr_path, kucun: $kucun, price: $price, wholesale_price: $wholesale_price, lf: $lf, name: $name, num: $num}';
  }
}

class ProSpecAttrItemBean implements ChooseBean {
  String id;
  String proid;
  String attr_name;
  String pid;
  String thiredid;
  String lay;

  ProSpecAttrItemBean(
      this.id, this.proid, this.attr_name, this.pid, this.thiredid, this.lay);

  factory ProSpecAttrItemBean.fromJson(Map<String, dynamic> json) =>
      ProSpecAttrItemBean(
        json["id"],
        json["proid"],
        json["attr_name"],
        json["pid"],
        json["thiredid"],
        json["lay"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "proid": proid,
        "attr_name": attr_name,
        "pid": pid,
        "thiredid": thiredid,
        "lay": lay,
      };

  @override
  String toString() {
    return 'ProSpecAttrItemBean{id: $id, proid: $proid, attr_name: $attr_name, pid: $pid, thiredid: $thiredid, lay: $lay}';
  }

  @override
  String getId() => this.id;

  @override
  String getName() => this.attr_name;
}
