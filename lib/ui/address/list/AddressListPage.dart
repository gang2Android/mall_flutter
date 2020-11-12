import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/address/AddressBean.dart';
import 'package:flutter_app_01/ui/address/AddressRepository.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/Checkbox2Widget.dart';
import 'package:flutter_app_01/widget/DefaultAppBar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  EasyRefreshController _controller = EasyRefreshController();

  AddressRepository _addressRepository = AddressRepository();
  List<AddressBean> _addressList = List();

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
      appBar: DefaultAppBar("我的地址"),
      body: _bodyView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          var result = App.router
              .navigateTo(context, Routes.addressDetailPage + "?isAdd=true");
          result.then((value) {
            if (value == null) {
              return;
            }
            if (value is bool) {
              if (value) {
                _getData();
              }
            }
          });
        },
      ),
    );
  }

  _bodyView() {
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
      child: ListView.builder(
        itemCount: _addressList == null ? 0 : _addressList.length,
        itemBuilder: (BuildContext context, int index) {
          AddressBean item = _addressList[index];
          return _itemView(item, index);
        },
      ),
      emptyWidget: _emptyView(),
    );
  }

  _itemView(AddressBean item, int index) {
    var supItemView = Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${item.receiveName}",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Container(width: 10.0),
              Text(
                "${item.mobile}",
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              Expanded(child: Container()),
              Text(
                item.isDefault == "1" ? "默认" : "",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
          Text(
            "${item.province + item.city + item.county + item.town + item.address}",
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              InkWell(
                child:
                    Checkbox2Widget(isCheck: item.isDefault == "1", text: "默认"),
                onTap: () {
                  _setDefault(item, index, item.isDefault == "1");
                },
              ),
              Expanded(child: Container()),
              RaisedButton(
                onPressed: () {
                  String info = json.encode(item.toJson());
                  info = Uri.encodeComponent(info);
                  var result = App.router.navigateTo(context,
                      Routes.addressDetailPage + "?isAdd=false&info=$info");
                  result.then((value) {
                    if (value == null) {
                      return;
                    }
                    if (value is bool) {
                      if (value) {
                        _getData();
                      }
                    }
                  });
                },
                child: Text("编辑"),
              ),
              Container(width: 10.0),
              RaisedButton(
                onPressed: () {
                  _delItem(index, item);
                },
                child: Text("删除"),
              ),
            ],
          ),
        ],
      ),
    );
    return supItemView;
  }

  _emptyView() {
    if (_addressList == null || _addressList.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Text("没有数据了"),
      );
    }
    return null;
  }

  /// **************************************************************************

  Future<void> _onRefresh() async {
    _getData();
  }

  void _getData({bool isLoadMore = false}) {
    if (!isLoadMore) {
      _page = 1;
      this._addressList.clear();
      setState(() {});
    }

    _addressRepository.getAddressList(
      _page,
      (data) {
        _page = _page + 1;
        if (this._addressList == null) this._addressList = List();
        this._addressList.addAll(data);
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

  void _setDefault(AddressBean item, int index, bool isDefault) {
    if (isDefault) {
      return;
    }
    // _addressRepository.setDefaultItem();
    _addressList.forEach(
      (element) {
        element.isDefault = "0";
      },
    );
    item.isDefault = isDefault ? "0" : "1";
    _addressList[index] = item;
    print(_addressList);
    setState(() {});
  }

  void _delItem(int index, AddressBean item) {
    _addressRepository.delAddressItem(
      item.id,
      (data) {
        _page = 1;
        _getData();
      },
      (error) {
        Toast.toast(context, error, isError: true);
      },
    );
  }
}
