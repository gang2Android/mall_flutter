class CollectBean {
  String collectId;
  String id;
  String proname;
  String img;
  String vipprice;

  CollectBean(this.collectId, this.id, this.proname,this.img, this.vipprice);

  CollectBean.fromJson(Map<String, dynamic> json) {
    collectId = json['collectId'];
    id = json['id'];
    proname = json['proname'];
    img = json['img'];
    vipprice = json['vipprice'];
  }
}
