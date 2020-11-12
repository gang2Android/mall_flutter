class ProListBean {
  List<ProListItemBean> data_list;

  ProListBean(this.data_list);

  ProListBean.fromJson(Map<String, dynamic> json) {
    data_list = List<ProListItemBean>();
    json['data_list'].forEach((v) {
      data_list.add(new ProListItemBean.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() => {
        "data_list": data_list,
      };
}

class ProListItemBean {
  String proid;
  String proimg;
  String proname;
  String marketprice;
  String vipprice;
  String lf;

  ProListItemBean(this.proid, this.proimg, this.proname, this.marketprice,
      this.vipprice, this.lf);

  factory ProListItemBean.fromJson(Map<String, dynamic> json) =>
      ProListItemBean(
        json["proid"],
        json["proimg"],
        json["proname"],
        json["marketprice"],
        json["vipprice"],
        json["lf"],
      );

  Map<String, dynamic> toJson() => {
        "proid": proid,
        "proimg": proimg,
        "proname": proname,
        "vipprice": vipprice,
        "marketprice": marketprice,
        "vipprice": vipprice,
        "lf": lf,
      };
}
