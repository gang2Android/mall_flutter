class HomeBean {
  List<HomeBannerBean> banner;
  HomeChainBean qukuaiconfig;
  List<HomeGuangGaoBean> guanggaoBanner;
  List<HomeFastBean> category;
  List<HomeProBean> list;

  List<HomeChainTemp> chainTemp;
  List<HomeArticleTemp> articleTemp;

  HomeBean(this.banner, this.guanggaoBanner, this.category, this.list);

  HomeBean.fromJson(Map<String, dynamic> json) {
    banner = List<HomeBannerBean>();
    json['banner'].forEach((v) {
      banner.add(new HomeBannerBean.fromJson(v));
    });
    qukuaiconfig = HomeChainBean.fromJson(json["qukuaiconfig"]);
    guanggaoBanner = List<HomeGuangGaoBean>();
    json['guanggaoBanner'].forEach((v) {
      guanggaoBanner.add(new HomeGuangGaoBean.fromJson(v));
    });
    category = List<HomeFastBean>();
    json['category'].forEach((v) {
      category.add(new HomeFastBean.fromJson(v));
    });
    list = List<HomeProBean>();
    json['list'].forEach((v) {
      list.add(new HomeProBean.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() => {
        "banner": banner,
        "category": category,
        "list": list,
      };
}

class HomeBannerBean {
  String poster_name;
  String poster_url;
  String type;
  String poster_picpath;

  HomeBannerBean(
      this.poster_name, this.poster_url, this.type, this.poster_picpath);

  factory HomeBannerBean.fromJson(Map<String, dynamic> json) => HomeBannerBean(
      json["poster_name"],
      json["poster_url"],
      json["type"],
      json["poster_picpath"]);

  Map<String, dynamic> toJson() => {
        "poster_name": poster_name,
        "poster_url": poster_url,
        "type": type,
        "poster_picpath": poster_picpath,
      };
}

class HomeChainBean {
  String homeWebsiteImg;
  String homeWebsiteLink;
  String homePlImg;
  String homePlLink;
  String homeGithubImg;
  String homeGithubLink;

  HomeChainBean(this.homeWebsiteImg, this.homeWebsiteLink, this.homePlImg,
      this.homePlLink, this.homeGithubImg, this.homeGithubLink);

  factory HomeChainBean.fromJson(Map<String, dynamic> json) => HomeChainBean(
        json["homeWebsiteImg"],
        json["homeWebsiteLink"],
        json["homePlImg"],
        json["homePlLink"],
        json["homeGithubImg"],
        json["homeGithubLink"],
      );

  Map<String, dynamic> toJson() => {
        "homeWebsiteImg": homeWebsiteImg,
        "homeWebsiteLink": homeWebsiteLink,
        "homePlImg": homePlImg,
        "homePlLink": homePlLink,
        "homeGithubImg": homeGithubImg,
        "homeGithubLink": homeGithubLink,
      };
}

class HomeChainTemp {
  String img;
  String url;

  HomeChainTemp(this.img, this.url);
}

class HomeArticleTemp {
  String id;
  String ArticleTitle;
  String ArticleContent;
  String addtime;

  HomeArticleTemp(
      this.id, this.ArticleTitle, this.ArticleContent, this.addtime);

  factory HomeArticleTemp.fromJson(Map<String, dynamic> json) =>
      HomeArticleTemp(json["id"].toString(), json["ArticleTitle"], json["ArticleContent"],
          json["addtime"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "ArticleTitle": ArticleTitle,
        "ArticleContent": ArticleContent,
        "addtime": addtime,
      };
}

class HomeGuangGaoBean {
  String poster_name;
  String poster_url;
  String type;
  String poster_picpath;

  HomeGuangGaoBean(
      this.poster_name, this.poster_url, this.type, this.poster_picpath);

  factory HomeGuangGaoBean.fromJson(Map<String, dynamic> json) =>
      HomeGuangGaoBean(json["poster_name"], json["poster_url"], json["type"],
          json["poster_picpath"]);

  Map<String, dynamic> toJson() => {
        "poster_name": poster_name,
        "poster_url": poster_url,
        "type": type,
        "poster_picpath": poster_picpath,
      };
}

class HomeFastBean {
  String id;
  String name;
  String photo;

  HomeFastBean(this.id, this.name, this.photo);

  factory HomeFastBean.fromJson(Map<String, dynamic> json) => HomeFastBean(
        json["id"],
        json["name"],
        json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
      };
}

class HomeProBean {
  String proid;
  String proname;
  String marketprice;
  String vipprice;
  String shop_type;
  String img;
  String lf;

  HomeProBean(this.proid, this.proname, this.marketprice, this.vipprice,
      this.shop_type, this.img, this.lf);

  factory HomeProBean.fromJson(Map<String, dynamic> json) => HomeProBean(
        json["proid"],
        json["proname"],
        json["marketprice"],
        json["vipprice"],
        json["shop_type"],
        json["img"],
        json["lf"],
      );

  Map<String, dynamic> toJson() => {
        "proid": proid,
        "proname": proname,
        "marketprice": marketprice,
        "vipprice": vipprice,
        "shop_type": shop_type,
        "img": img,
        "lf": lf,
      };
}
