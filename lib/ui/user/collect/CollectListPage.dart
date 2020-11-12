import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/user/UserRepository.dart';
import 'package:flutter_app_01/ui/user/collect/CollectBean.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/DefaultAppBar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CollectListPage extends StatefulWidget {
  @override
  _CollectListPageState createState() => _CollectListPageState();
}

class _CollectListPageState extends State<CollectListPage> {
  EasyRefreshController _controller = EasyRefreshController();
  UserRepository _userRepository = UserRepository();
  List<CollectBean> _collectList = List();

  int _page = 1;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("我的收藏"),
      body: EasyRefresh(
        header: BallPulseHeader(),
        footer: BallPulseFooter(),
        topBouncing: true,
        bottomBouncing: true,
        controller: _controller,
        onRefresh: _onRefresh,
        // onLoad: () async {
        //   _getData(isLoadMore: true);
        // },
        child: ListView.builder(
          itemCount: _collectList == null ? 0 : _collectList.length,
          itemBuilder: (BuildContext context, int index) {
            CollectBean item = _collectList[index];
            return _itemView(item, index);
          },
        ),
        emptyWidget: _emptyView(),
      ),
    );
  }

  _emptyView() {
    if (_collectList == null || _collectList.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Text("没有数据了"),
      );
    }
    return null;
  }

  Widget _itemView(CollectBean item, int index) {
    var childView = Row(
      children: [
        Image.network(item.img, width: 100, height: 100),
        Container(width: 5.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.proname,
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    "￥",
                    style: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                  Expanded(
                    child: Text(
                      "${item.vipprice}",
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    ),
                  ),
                  InkWell(
                    child: Chip(
                      label: Text("删除"),
                      deleteIcon: Icon(Icons.close_sharp),
                      onDeleted: (){
                        _delCollect(item, index);
                      },
                    ),
                    onTap: () {
                      _delCollect(item, index);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.grey[300],
          width: 1,
        ),
        color: Colors.white,
      ),
      child: InkWell(
        child: childView,
        onTap: () {
          App.router.navigateTo(
              context, Routes.proDetailPage + "?proId=${item.collectId}");
        },
      ),
    );
  }

  /// **************************************************************************

  Future<void> _onRefresh() async {
    _getData();
  }

  void _getData({bool isLoadMore = false}) {
    if (!isLoadMore) {
      _page = 1;
      this._collectList.clear();
      setState(() {});
    }

    _userRepository.getCollectList(
      _page,
      (data) {
        _page = _page + 1;
        if (this._collectList == null) this._collectList = List();
        this._collectList.addAll(data);
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
      },
      (error) {
        Toast.toast(context, error, isError: true);
        print("error=" + error + "---page=$_page");
        try {
          _controller.resetLoadState();
          if (isLoadMore) {
            _controller.finishLoad(noMore: _page != 1);
          } else {
            _controller.finishRefresh();
          }
        } catch (e) {
          _controller = EasyRefreshController();
          _controller.resetLoadState();
          if (isLoadMore) {
            _controller.finishLoad(noMore: _page != 1);
          } else {
            _controller.finishRefresh();
          }
        }
        if (_page == 1) {
          setState(() {});
        }
      },
    );
  }

  void _delCollect(CollectBean item, int index) {
    _userRepository.delCollect(
      item.id,
      (data) {
        Toast.toast(context, data);
        _collectList.removeAt(index);
        setState(() {});
      },
      (error) {
        Toast.toast(context, error, isError: true);
      },
    );
  }
}
