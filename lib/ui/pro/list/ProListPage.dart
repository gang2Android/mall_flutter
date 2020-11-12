import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/pro/ProRepository.dart';
import 'package:flutter_app_01/ui/pro/list/ProListBean.dart';
import 'package:flutter_app_01/utils/ImageUtils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ProListPage extends StatefulWidget {
  final String keyStr;
  final String cid;
  final String shop_type;

  const ProListPage(
      {Key key, this.keyStr = "", this.cid = "", this.shop_type = ""})
      : super(key: key);

  @override
  _ProListPageState createState() => _ProListPageState();
}

class _ProListPageState extends State<ProListPage> {
  final List<String> _tabs = ['全部', '百货区', '精品区', '名品区', '联盟区'];

  EasyRefreshController _controller = EasyRefreshController();

  double width = 0;

  int page = 1;
  int sort = 1;
  String key = "";
  String cid = "";
  String shop_type = "";

  bool _isEmpty = false;

  ProRepository proListRepository = ProRepository();
  List<ProListItemBean> proListBean = List();

  @override
  void initState() {
    super.initState();
    shop_type = widget.shop_type;
    cid = widget.cid;
    key = widget.keyStr;

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: this._tabs.length,
      child: Scaffold(
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
                child: Text(this.key.isEmpty ? "搜索" : this.key),
              ),
              onTap: () {
                App.router.navigateTo(
                  context,
                  Routes.searchPage,
                  replace: true,
                );
              },
            ),
            backgroundColor: Colors.white,
          ),
          toolbarHeight: 150.0,
          backgroundColor: Color(App.appColor),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: _topAreaView(),
          ),
        ),
        body: _proView(),
      ),
    );
  }

  _topAreaView() {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          onTap: (index) {
            String type = "";
            switch (index) {
              case 0:
                type = "";
                break;
              case 1:
                type = "1";
                break;
              case 2:
                type = "2";
                break;
              case 3:
                type = "4";
                break;
              case 4:
                type = "7";
                break;
            }
            this.page = 1;
            this.shop_type = type;
            _getData();
          },
        ),
        Container(
          color: Colors.grey[300],
          margin: const EdgeInsets.only(top: 2.0),
          height: 1.0,
        ),
        _topSortView(),
      ],
    );
  }

  _topSortView() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (this.sort == 1) return;
              setState(() {
                this.page = 1;
                this.sort = 1;
              });
              _getData();
            },
            child: Container(
              color: Colors.white,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                "综合",
                style: TextStyle(
                  color: this.sort == 1 ? Color(0xFFFFAC34) : Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (this.sort == 3) return;
              setState(() {
                this.page = 1;
                this.sort = 3;
              });
              _getData();
            },
            child: Container(
              color: Colors.white,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                "销量",
                style: TextStyle(
                  color: this.sort == 3 ? Color(0xFFFFAC34) : Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (this.sort == 4) return;
              setState(() {
                this.page = 1;
                this.sort = 4;
              });
              _getData();
            },
            child: Container(
              color: Colors.white,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                "价格",
                style: TextStyle(
                  color: this.sort == 4 ? Color(0xFFFFAC34) : Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (this.sort == 6) return;
              setState(() {
                this.page = 1;
                this.sort = 6;
              });
              _getData();
            },
            child: Container(
              color: Colors.white,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                "链分值",
                style: TextStyle(
                  color: this.sort == 6 ? Color(0xFFFFAC34) : Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (this.sort == 8) return;
              setState(() {
                this.page = 1;
                this.sort = 8;
              });
              _getData();
            },
            child: Container(
              color: Colors.white,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                "链分值比例",
                style: TextStyle(
                  color: this.sort == 8 ? Color(0xFFFFAC34) : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _proView() {
    return EasyRefresh(
      header: BallPulseHeader(),
      footer: BallPulseFooter(),
      topBouncing: true,
      bottomBouncing: true,
      controller: _controller,
      onRefresh: _onRefresh,
      onLoad: () async {
        _getData(isLoadMore: true);
      },
      child: GridView.builder(
        itemCount: proListBean == null ? 0 : proListBean.length,
        itemBuilder: (BuildContext context, int index) {
          ProListItemBean itemBean = proListBean[index];
          return _proItemView(index, itemBean);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.7,
        ),
      ),
      emptyWidget: _emptyView(),
    );
  }

  _emptyView() {
    if (_isEmpty) {
      return Center(
        child: Text("没有数据..."),
      );
    }
    return null;
  }

  _proItemView(int index, ProListItemBean itemBean) {
    double itemWidth = width / 2 - 6;
    double radius = 10.0;
    return InkWell(
      onTap: () {
        App.router.navigateTo(
            context, Routes.proDetailPage + "?proId=${itemBean.proid}");
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
                  ImageUtils.handleUrl(itemBean.proimg),
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
                      itemBean.proname,
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
                          "¥" + itemBean.vipprice.toString(),
                          style: TextStyle(color: Colors.red, fontSize: 18.0),
                        ),
                        Container(width: 2.0),
                        Text(
                          "¥" + itemBean.marketprice.toString(),
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
          )),
    );
  }

  Future<void> _onRefresh() async {
    _getData();
  }

  /// ==========================================================================

  _getData({isLoadMore: false}) {
    if (!isLoadMore) {
      page = 1;
      this.proListBean = null;
      setState(() {});
    }
    proListRepository.getProList((data) {
      page = page + 1;
      _isEmpty = false;
      // _hanError(isLoadMore);
      if (this.proListBean == null) this.proListBean = List();
      this.proListBean.addAll(data);
      setState(() {});

      try {
        _controller.resetLoadState();
        if (isLoadMore) {
          _controller.finishLoad(noMore: false);
        } else {
          _controller.finishRefresh();
        }
      } catch (e) {
        _controller = EasyRefreshController();
        _controller.resetLoadState();
        if (isLoadMore) {
          _controller.finishLoad(noMore: false);
        } else {
          _controller.finishRefresh();
        }
      }
    }, (error) {
      try {
        _controller.resetLoadState();
        if (isLoadMore) {
          _controller.finishLoad(noMore: page != 1);
        } else {
          _controller.finishRefresh();
        }
      } catch (e) {
        _controller = EasyRefreshController();
        _controller.resetLoadState();
        if (isLoadMore) {
          _controller.finishLoad(noMore: page != 1);
        } else {
          _controller.finishRefresh();
        }
      }
      if (page == 1) {
        _isEmpty = true;
        setState(() {});
      }
    }, shop_type: shop_type, sort: sort, page: page, key: key);
  }

  /// 未知错误,暂时以这种方式处理
  /// 问题链接：https://github.com/xuelongqy/flutter_easyrefresh/issues/352
  _hanError(isLoadMore) {
    try {
      _controller.resetLoadState();
      if (isLoadMore) {
        _controller.finishLoad(noMore: true);
      } else {
        _controller.finishRefresh();
      }
    } catch (e) {
      print(e);
      _controller = EasyRefreshController();
      _controller.resetLoadState();
      if (isLoadMore) {
        _controller.finishLoad(noMore: false);
      } else {
        _controller.finishRefresh();
      }
    }
  }
}
