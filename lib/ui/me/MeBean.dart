class MeBean {
  String UserId;
  String Nickname;
  String TrueName;
  String AvatarUrl;

  String userType;
  String invitecode;
  String user_block_hash;

  String Umoney;
  String Pv;
  String repeat_money;

  String jl_userid;
  String jl_name;
  String jl_zero;

  MeBean(
      this.UserId,
      this.Nickname,
      this.TrueName,
      this.AvatarUrl,
      this.userType,
      this.invitecode,
      this.user_block_hash,
      this.Umoney,
      this.Pv,
      this.repeat_money,
      this.jl_userid,
      this.jl_name,
      this.jl_zero);

  factory MeBean.fromJson(Map<String, dynamic> json) => MeBean(
        json["UserId"],
        json["Nickname"],
        json["TrueName"],
        json["AvatarUrl"],
        json["userType"],
        json["invitecode"],
        json["user_block_hash"],
        json["Umoney"],
        json["Pv"],
        json["repeat_money"],
        json["jl_userid"],
        json["jl_name"],
        json["jl_zero"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": UserId,
        "Nickname": Nickname,
        "TrueName": TrueName,
        "AvatarUrl": AvatarUrl,
        "userType": userType,
        "invitecode": invitecode,
        "user_block_hash": user_block_hash,
        "Umoney": Umoney,
        "Pv": Pv,
        "repeat_money": repeat_money,
        "jl_userid": jl_userid,
        "jl_name": jl_name,
        "jl_zero": jl_zero,
      };

  @override
  String toString() {
    return 'MeBean{UserId: $UserId, Nickname: $Nickname, TrueName: $TrueName, AvatarUrl: $AvatarUrl, userType: $userType, invitecode: $invitecode, user_block_hash: $user_block_hash, Umoney: $Umoney, Pv: $Pv, repeat_money: $repeat_money, jl_userid: $jl_userid, jl_name: $jl_name, jl_zero: $jl_zero}';
  }
}
