import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/home/HomeBean.dart';
import 'package:flutter_app_01/ui/home/HomeRepository.dart';
import 'package:flutter_app_01/utils/ImageUtils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller = EasyRefreshController();

  double width = 0;

  HomeRepository _homeRepository = HomeRepository();

  HomeBean homeBean;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    _homeRepository.getHomeBean((data) {
      _controller.resetLoadState();
      _controller.finishRefresh();
      setState(() {
        homeBean = data;
      });
    }, (error) {
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
      body: EasyRefresh(
        header: BallPulseHeader(),
        // footer: BallPulseFooter(),
        topBouncing: true,
        bottomBouncing: true,
        controller: _controller,
        onRefresh: _onRefresh,
        // onLoad: () async {
        //   await Future.delayed(Duration(seconds: 2), () {
        //     _controller.resetLoadState();
        //     _controller.finishLoad(noMore: true);
        //   });
        // },
        child: CustomScrollView(
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          slivers: _contentWidget(),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    getData();
  }

  List<Widget> _contentWidget() {
    List<Widget> items = List<Widget>();
    if (homeBean == null) {
      return items;
    }
    items.add(_bannerView());

    items.add(_noticeView());

    items.add(_guanggaoBanner());

    items.add(_chainView());

    items.add(_tempView());

    items.add(_categoryView());

    items.add(_tempView());

    items.add(_proView());

    return items;
  }

  _tempView() {
    return SliverToBoxAdapter(
      child: Container(
        height: 5.0,
        // color: Colors.white,
      ),
    );
  }

  _bannerView() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 2.083333333333333,
        // margin: EdgeInsets.only(bottom: 10.0),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              homeBean.banner[index].poster_picpath,
              fit: BoxFit.contain,
            );
          },
          itemCount: homeBean.banner.length,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  size: 6.0, activeSize: 6.0, color: Colors.grey)),
          autoplay: true,
        ),
      ),
    );
  }

  _noticeView() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Row(
          children: [
            Text("公告"),
            Container(width: 10.0, height: 1.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 30.0,
              child: Swiper(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            homeBean.articleTemp[index].ArticleTitle,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: homeBean.articleTemp.length,
                autoplay: true,
                onTap: (index) {
                  var item = homeBean.articleTemp[index].toJson();
                  String str = json.encode(item);
                  // App.router.navigateTo(context, Routes.h5Page + "?html=$str");
                  App.router.navigateTo(context,
                      Routes.h5Page + "?data=${Uri.encodeComponent(str)}");
                },
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.blue,
                // width: MediaQuery.of(context).size.width * 0.15,
                height: 30.0,
                alignment: Alignment.centerRight,
                child: Text("更多 >",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[400],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _guanggaoBanner() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1 / 0.52,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var item = homeBean.guanggaoBanner[index];
        return InkWell(
          onTap: () {
            int type = 1;
            switch (index) {
              case 0:
                type = 4;
                break;
              case 1:
                type = 2;
                break;
              case 2:
                type = 1;
                break;
              case 3:
                type = 7;
                break;
            }
            App.router
                .navigateTo(context, Routes.proListPage + "?shop_type=$type");
          },
          child: new Container(
            color: Colors.white,
            margin: const EdgeInsets.all(0.0),
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Image.network(item.poster_picpath),
          ),
        );
      }, childCount: homeBean.guanggaoBanner.length),
    );
  }

  _chainView() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1 / 0.68,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var item = homeBean.chainTemp[index];
        double left = 5.0;
        double right = 5.0;
        if (index == 0) {
          left = 5.0;
          right = 0.0;
        } else if (index == (homeBean.chainTemp.length - 1)) {
          left = 0.0;
          right = 5.0;
        }
        return InkWell(
          onTap: () async {
            if (await canLaunch(item.url)) {
              await launch(item.url);
            }
          },
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.all(0.0),
            padding: EdgeInsets.only(left: left, right: right),
            alignment: Alignment.center,
            child: Image.network(item.img),
          ),
        );
      }, childCount: homeBean.chainTemp.length),
    );
  }

  _categoryView() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        // mainAxisSpacing: 0.0,
        // crossAxisSpacing: 0.0,
        // childAspectRatio: 0.9,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var item = homeBean.category[index];
        return InkWell(
          onTap: () {
            App.router
                .navigateTo(context, Routes.proListPage + "?cid=${item.id}");
          },
          child: new Container(
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(item.photo, width: 50.0, height: 50.0),
                    Container(height: 5.0),
                    Text(item.name)
                  ],
                )
              ],
            ),
          ),
        );
      }, childCount: homeBean.category.length),
    );
  }

  _proView() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // mainAxisSpacing: 0.0,
        // crossAxisSpacing: 0.0,
        childAspectRatio: 2 / 2.7,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var item = homeBean.list[index];
        // var width = MediaQuery.of(context).size.width / 2 - 10;
        return _proItem(item);
      }, childCount: homeBean.list.length),
    );
  }

  _proItem(HomeProBean item) {
    double itemWidth = width / 2 - 10;
    double radius = 10.0;
    return InkWell(
      onTap: () {
        App.router
            .navigateTo(context, Routes.proDetailPage + "?proId=${item.proid}");
      },
      child: Container(
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
              child: Image.network(
                ImageUtils.handleUrl(item.img),
                width: itemWidth,
                height: itemWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              margin: const EdgeInsets.only(top: 5.0),
              child: Column(
                children: [
                  Text(
                    item.proname,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "¥" + item.vipprice.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 18.0),
                      ),
                      Container(width: 2.0),
                      Text(
                        "¥" + item.marketprice.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
