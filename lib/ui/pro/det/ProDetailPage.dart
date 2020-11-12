import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/base/BaseState.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/pro/ProRepository.dart';
import 'package:flutter_app_01/ui/pro/det/ProDetailBean.dart';
import 'package:flutter_app_01/ui/pro/det/ProSpecWidget.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ProDetailPage extends StatefulWidget {
  final String proId;

  const ProDetailPage({Key key, @required this.proId}) : super(key: key);

  @override
  _ProDetailPageState createState() => _ProDetailPageState();
}

class _ProDetailPageState extends BaseState<ProDetailPage> {
  ProRepository _proRepository = ProRepository();
  ProDetailBean _proDetailBean;
  ProSpecAttrPathBean _selectSpec;

  double width = 0;

  @override
  void initState() {
    super.initState();
    _proRepository.getProDetail(widget.proId, (data) {
      _proDetailBean = data;

      _selectSpec = _proDetailBean.guige.attr_path[0];
      _selectSpec.name = "";

      setState(() {});
    }, (error) {
      print(error);
    });
  }

  @override
  Widget getContentWidget(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Chip(
          label: GestureDetector(
            child: Container(
              width: width * 0.8,
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              alignment: Alignment.center,
              child: Text("搜索"),
            ),
            onTap: () {
              App.router.navigateTo(context, Routes.searchPage);
            },
          ),
          backgroundColor: Colors.white,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        // shrinkWrap: true,
        scrollDirection: Axis.vertical,
        slivers: _contentView(),
      ),
      bottomNavigationBar: _bottomView(),
    );
  }

  _contentView() {
    List<Widget> itemViews = List();
    if (_proDetailBean == null) return itemViews;

    itemViews.add(_bannerView());

    itemViews.add(_baseInfoView());
    itemViews.add(_tempView());

    itemViews.add(_specInfoView());
    itemViews.add(_tempView());

    itemViews.add(_evaluationView());
    itemViews.add(_tempView());

    itemViews.add(_imgTextInfoView());
    itemViews.add(_tempView());

    return itemViews;
  }

  _tempView() {
    return SliverPadding(
      padding: const EdgeInsets.all(0.0),
      sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Container(
          height: 5.0,
          // color: Colors.white,
        )
      ])),
    );
  }

  _bannerView() {
    double width = MediaQuery.of(context).size.width;

    return SliverPadding(
      padding: const EdgeInsets.all(0.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            Container(
              color: Colors.white,
              width: width,
              height: width,
              // margin: EdgeInsets.only(bottom: 10.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _proDetailBean.imgalbum[index],
                    fit: BoxFit.contain,
                  );
                },
                itemCount: _proDetailBean.imgalbum.length,
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        size: 6.0, activeSize: 6.0, color: Colors.grey)),
                autoplay: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _baseInfoView() {
    ProDetailInfoBean detail = _proDetailBean.datails;
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        // height: width * 0.28,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                detail.proname,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(fontSize: 18.0, color: Colors.black, height: 1.2),
              ),
            ),
            Text(
              "会员价：￥" + (_selectSpec == null ? "0.00" : _selectSpec.price),
              style: TextStyle(fontSize: 18.0, color: Colors.red),
              maxLines: 1,
            ),
            Text(
              "市场价：￥" +
                  (_selectSpec == null ? "0.00" : _selectSpec.wholesale_price),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[400],
                decoration: TextDecoration.lineThrough,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  _specInfoView() {
    if (_selectSpec == null || _selectSpec.name == "") {
      return SliverToBoxAdapter(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ListTile(
            title: Text(
              "点击选择商品属性",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            contentPadding: const EdgeInsets.only(left: 5.0),
            onTap: () {
              _showSpec(type: 0);
            },
          ),
        ),
      );
    }
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ListTile(
          title: Text(
            "已选择：",
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            (_selectSpec == null ? "" : _selectSpec.name),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          contentPadding: const EdgeInsets.only(left: 5.0),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _showSpec(type: 0);
          },
        ),
      ),
    );
  }

  Widget _evaluationView() {
    List<Widget> items = List();
    items.add(Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text("商品评价", style: TextStyle(fontSize: 14.0)),
          Expanded(child: Container()),
          Text(
            "查看更多>",
            style: TextStyle(fontSize: 12.0, color: Color(0xFFFFAC34)),
          ),
        ],
      ),
    ));
    List<ProEvaluationBean> datas = _proDetailBean.evaluation;
    for (int i = 0; i < datas.length; i++) {
      ProEvaluationBean item = datas[i];
      items.add(_evaluationItemView(item));
    }
    return SliverList(
      delegate: SliverChildListDelegate(items),
    );
  }

  _evaluationItemView(ProEvaluationBean item) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(item.userImg, width: 50.0, height: 50.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.userName,
                      style: TextStyle(fontSize: 12.0, color: Colors.black)),
                  Text(item.specName,
                      style:
                          TextStyle(fontSize: 12.0, color: Colors.grey[400])),
                ],
              ),
            ],
          ),
          Text(item.content,
              style: TextStyle(fontSize: 14.0, color: Colors.black)),
          Row(
            children: [
              Text(
                item.time,
                style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item.zanNum,
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _imgTextInfoView() {
    String infoStr = _proDetailBean.datails.description;
    return SliverPadding(
      padding: const EdgeInsets.all(0.0),
      sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Container(
          alignment: Alignment.center,
          color: Colors.white,
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            "图文详情",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        HtmlWidget(infoStr),
      ])),
    );
  }

  _bottomView() {
    return Container(
      color: Colors.white,
      height: 56.0,
      child: Row(
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.collections,
                    color: _proDetailBean != null && _proDetailBean.isCollect
                        ? Color(App.appColor)
                        : null,
                  ),
                  Text(
                    "收藏",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: _proDetailBean != null && _proDetailBean.isCollect
                          ? Color(App.appColor)
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              _addCollect();
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share),
                  Text("分享", style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
            onTap: () {
              print("分享");
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart),
                  Text("购物车", style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
            onTap: () {
              print("购物车");
            },
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                color: Colors.black,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: Text(
                  "加入购物车",
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
              onTap: () {
                print("加入购物车");
                _showSpec(type: 1);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                color: Color(App.appColor),
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: Text(
                  "立即购买",
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
              onTap: () {
                print("立即购买");
                _showSpec(type: 2);
              },
            ),
          ),
        ],
      ),
    );
  }

  _showSpec({int type = 0}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ProSpecWidget(proDetailBean: _proDetailBean);
      },
    ).then((val) {
      if (val == null) return;
      if (val is ProSpecAttrPathBean) {
        setState(() {
          _selectSpec = val;
        });
        if (!val.isClose) {
          switch (type) {
            case 0:
              break;
            case 1:
              // 加入购物车
              _proRepository.addCart(
                _proDetailBean.datails.proid,
                _selectSpec.styleid,
                _selectSpec.num,
                _selectSpec.address,
                (msg) {
                  Toast.toast(context, msg);
                },
                (error) {
                  Toast.toast(context, error, isError: true);
                },
              );
              break;
            case 2:
              // 立即购买
              String path = Routes.orderAffirmPage;
              path += "?isCart=false";
              path += "&shopType=${_proDetailBean.datails.shop_type}";
              path += "&proId=${_proDetailBean.datails.proid}";
              path += "&styleId=${_selectSpec.styleid}";
              path += "&proNum=${_selectSpec.num}";
              path += "&addressId=${_selectSpec.address}";
              App.router.navigateTo(context, path);
              break;
          }
        }
      }
    });
  }

  void _addCollect() {
    if (App.token == "") {
      App.router.navigateTo(context, Routes.userLoginPage);
    } else {
      _proRepository.addCollect(_proDetailBean.datails.proid, (data) {
        Toast.toast(context, data);
        setState(() {
          _proDetailBean.isCollect = !_proDetailBean.isCollect;
        });
      }, (error) {
        Toast.toast(context, error, isError: true);
      });
    }
  }
}
