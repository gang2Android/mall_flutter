class AddressBean {
  String id;
  String userId;
  String receiveName;
  String mobile;
  String province;
  String city;
  String county;
  String town;
  String address;
  String isDefault;

  AddressBean(
      this.id,
      this.userId,
      this.receiveName,
      this.mobile,
      this.province,
      this.city,
      this.county,
      this.town,
      this.address,
      this.isDefault);

  AddressBean.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    receiveName = json["receiveName"];
    mobile = json["mobile"];
    province = json["province"];
    city = json["city"];
    county = json["county"];
    town = json["town"];
    address = json["address"];
    isDefault = json["isDefault"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = Map();
    result["id"] = id;
    result["userId"] = userId;
    result["receiveName"] = receiveName;
    result["mobile"] = mobile;
    result["province"] = province;
    result["city"] = city;
    result["county"] = county;
    result["town"] = town;
    result["address"] = address;
    result["isDefault"] = isDefault;
    return result;
  }

  @override
  String toString() {
    return 'AddressBean{id: $id, userId: $userId, receiveName: $receiveName, mobile: $mobile, province: $province, city: $city, county: $county, town: $town, address: $address, isDefault: $isDefault}';
  }
}
