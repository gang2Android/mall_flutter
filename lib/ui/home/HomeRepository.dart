import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/home/HomeBean.dart';
import 'package:flutter_app_01/utils/RequestUtils.dart';

class HomeRepository {
  getHomeBean(Function success, Function error) async {
    String url = App.DOMAIN_API + "item-web/index/getIndexData";
    String url1 = App.DOMAIN_MEM + "api.php/index/article_list";

    Map<String, dynamic> data =
        await RequestUtils.getInstance().getOfAwait(url);
    Map<String, dynamic> data0 =
        await RequestUtils.getInstance().getOfAwait(url1, successStatus: "0");

    if (data.containsKey("msg")) {
      error(data["msg"]);
      return;
    }
    data = data["data"];
    if (data0.containsKey("msg")) {
      error(data0["msg"]);
      return;
    }
    List<dynamic> data1 = data0["data"];

    try {
      var homeBean0 = HomeBean.fromJson(data);
      List<HomeChainTemp> chainTemps = List<HomeChainTemp>();
      var chainBean = homeBean0.qukuaiconfig;
      chainTemps.add(
          HomeChainTemp(chainBean.homeWebsiteImg, chainBean.homeWebsiteLink));
      chainTemps.add(HomeChainTemp(chainBean.homePlImg, chainBean.homePlLink));
      chainTemps.add(
          HomeChainTemp(chainBean.homeGithubImg, chainBean.homeGithubLink));
      homeBean0.chainTemp = chainTemps;

      List<HomeArticleTemp> articleTemps = List();
      for (int i = 0; i < data1.length; i++) {
        var item = data1[i];
        var articleTemp = HomeArticleTemp.fromJson(item);
        articleTemps.add(articleTemp);
      }
      homeBean0.articleTemp = articleTemps;
      success(homeBean0);
    } catch (e) {
      error(e.toString());
    }
  }
}
