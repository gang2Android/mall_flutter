import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/route/Routes.dart';
import 'package:flutter_app_01/ui/cart/CartBean.dart';
import 'package:flutter_app_01/ui/cart/CartRepository.dart';
import 'package:flutter_app_01/ui/pro/det/CountWidget.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/Checkbox2Widget.dart';
import 'package:flutter_app_01/widget/SingleChooseWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  CartRepository _cartRepository = CartRepository();
  EasyRefreshController _controller = EasyRefreshController();

  CartBean _cartBean;

  int shopType = 1;
  int page = 1;

  bool _isAllCheck = false;

  String _allMoney = "0.00";
  String _allFreight = "0.00";
  int _allNum = 0;

  @override
  bool get wantKeepAlive => true;

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
      appBar: AppBar(
        title: Text("购物车"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: _topView(),
        ),
      ),
    );
  }

  _topView() {
    List<CartTopBean> beans = List();
    beans.add(CartTopBean("1", "高档百货区"));
    beans.add(CartTopBean("2", "精品区"));
    beans.add(CartTopBean("7", "联盟商家区"));
    beans.add(CartTopBean("4", "名品区"));

    List<Widget> views = List();
    views.add(
      Container(
        padding: const EdgeInsets.all(5.0),
        child: SingleChooseWidget(
          list: beans,
          onChange: (item) {
            this.shopType = int.parse(item.getId());
            this.page = 1;
            _getData();
          },
        ),
      ),
    );
    if (_cartBean == null || _cartBean.data_list.length == 0) {
      views.add(
        Expanded(
          child: InkWell(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "暂无数据，请点击重试",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            onTap: () {
              _getData();
            },
          ),
        ),
      );
    } else {
      views.add(
        Expanded(
          child: _contentView(),
        ),
      );
      views.add(
        _bottomView(),
      );
    }

    return views;
  }

  _contentView() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: _cartBean == null ? 0 : _cartBean.data_list.length,
        itemBuilder: (BuildContext context, int index) {
          CartSupBean item = _cartBean.data_list[index];
          return _supView(item, index);
        },
      ),
    );
  }

  _supView(CartSupBean item, int index) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _supProView(item, index),
        ),
      ),
    );
  }

  _supProView(CartSupBean item, int index) {
    List<Widget> items = List();
    var top = Row(
      children: [
        InkWell(
          child: Checkbox2Widget(isCheck: item.isCheck),
          onTap: () {
            _setSupCheck(index, !item.isCheck);
          },
        ),
        Text(
          item.supname,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ],
    );
    items.add(top);

    for (int i = 0; i < item.sub.length; i++) {
      CartSupProBean itemPro = item.sub[i];
      items.add(
        Container(
          height: 1.0,
          color: Colors.grey[300],
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        ),
      );
      items.add(_supProItemView(itemPro, index, i));
    }

    return items;
  }

  _supProItemView(CartSupProBean item, int supIndex, int proIndex) {
    return Row(
      children: [
        InkWell(
          child: Checkbox2Widget(isCheck: item.isCheck),
          onTap: () {
            // _setCheck(false, !item.isCheck,
            //     supIndex: supIndex, proIndex: proIndex);
            _setProCheck(supIndex, proIndex, !item.isCheck);
          },
        ),
        Image.network(item.proimg, width: 100, height: 100),
        Container(width: 5.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.proname,
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                item.stylename,
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                maxLines: 1,
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
                      "${item.shopprice}",
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    ),
                  ),
                  CountView(
                    num: item.pronum,
                    max: 100,
                    callBack: (num) {
                      _setSupProNum(supIndex, proIndex, num);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _bottomView() {
    return Container(
      color: Colors.white,
      height: 56.0,
      child: Row(
        children: [
          InkWell(
            child: Checkbox2Widget(
              isCheck: _isAllCheck,
              text: "全选",
            ),
            onTap: () {
              _setAllCheck(!_isAllCheck);
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              // height: 56.0,
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("商品金额：$_allMoney"),
                  Text("运费：$_allFreight"),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              height: 56.0,
              width: MediaQuery.of(context).size.width * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(App.appColor),
              ),
              // padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Text(
                "结算($_allNum)",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            onTap: () {
              _getResult();
            },
          ),
        ],
      ),
    );
  }

  /// **************************************************************************

  Future<void> _onRefresh() async {
    _getData();
  }

  _getData() {
    _cartRepository.getCartList(
      shopType,
      page,
      _success,
      (error) {
        if (error is String) {
          // Toast.toast(context, error, isError: true);
          if (error.contains("登录")) {
            App.token = "";
            if (context == null || context.findAncestorStateOfType() == null) {
              return;
            }
            App.router.navigateTo(context, Routes.userLoginPage).then(
              (value) {
                if (value is bool) {
                  if (value) {
                    _getData();
                  }
                }
              },
            );
          } else {
            if (this.page == 1) {
              _success(null);
            }
          }
        }
      },
    );
  }

  _success(data) {
    if (context == null || context.findAncestorStateOfType() == null) {
      return;
    }
    _controller.resetLoadState();
    _controller.finishRefresh();

    _isAllCheck = false;
    _allMoney = "0.00";
    _allFreight = "0.00";
    _allNum = 0;
    _cartBean = data;
    setState(() {});
  }

  _setAllCheck(bool isChecked) {
    Future(() {
      _isAllCheck = isChecked;
      for (int i = 0; i < _cartBean.data_list.length; i++) {
        CartSupBean itemSup = _cartBean.data_list[i];
        itemSup.isCheck = isChecked;
        for (int i = 0; i < itemSup.sub.length; i++) {
          CartSupProBean itemPro = itemSup.sub[i];
          itemPro.isCheck = isChecked;
        }
      }
      return "next";
    }).then((result) {}).catchError((error) {}).whenComplete(() {
      _computeMoney();
    });
  }

  _setSupCheck(int supIndex, bool isChecked) {
    Future(() {
      _cartBean.data_list[supIndex].isCheck = isChecked;
      for (int i = 0; i < _cartBean.data_list[supIndex].sub.length; i++) {
        CartSupProBean itemPro = _cartBean.data_list[supIndex].sub[i];
        itemPro.isCheck = isChecked;
      }
      if (isChecked) {
        int count = 0;
        for (int i = 0; i < _cartBean.data_list.length; i++) {
          CartSupBean itemSup = _cartBean.data_list[i];
          if (itemSup.isCheck) {
            count += 1;
          }
        }
        if (count == _cartBean.data_list.length) {
          _isAllCheck = true;
        }
      } else {
        _isAllCheck = false;
        _cartBean.data_list[supIndex].isCheck = isChecked;
      }
      return "next";
    }).then((result) {}).catchError((error) {}).whenComplete(() {
      _computeMoney();
    });
  }

  _setProCheck(int supIndex, int proIndex, bool isChecked) {
    Future(() {
      _cartBean.data_list[supIndex].sub[proIndex].isCheck = isChecked;
      if (isChecked) {
        int count = 0;
        for (int i = 0; i < _cartBean.data_list[supIndex].sub.length; i++) {
          CartSupProBean item = _cartBean.data_list[supIndex].sub[i];
          if (item.isCheck) {
            count += 1;
          }
        }
        if (count == _cartBean.data_list[supIndex].sub.length) {
          _cartBean.data_list[supIndex].isCheck = true;
          _setSupCheck(supIndex, true);
          return "next";
        }
      } else {
        for (int i = 0; i < _cartBean.data_list[supIndex].sub.length; i++) {
          CartSupProBean item = _cartBean.data_list[supIndex].sub[i];
          if (!item.isCheck) {
            _cartBean.data_list[supIndex].isCheck = false;
            break;
          }
        }
        _isAllCheck = false;
      }
      return "next";
    }).then((result) {}).catchError((error) {}).whenComplete(() {
      _computeMoney();
    });
  }

  _setSupProNum(int supIndex, int proIndex, int num) {
    _cartBean.data_list[supIndex].sub[proIndex].pronum = num;
    _computeMoney();
  }

  _computeMoney() {
    Future(() {
      try {
        _allMoney = "0.00";
        _allFreight = "0.00";
        _allNum = 0;
        for (int i = 0; i < _cartBean.data_list.length; i++) {
          for (int j = 0; j < _cartBean.data_list[i].sub.length; j++) {
            var itemPro = _cartBean.data_list[i].sub[j];
            if (itemPro.isCheck) {
              _allNum += itemPro.pronum;

              var price = NumUtil.multiplyDecStr(
                      itemPro.shopprice, itemPro.pronum.toString())
                  .toStringAsFixed(2);
              _allMoney =
                  NumUtil.addDecStr(_allMoney, price).toStringAsFixed(2);

              var a = itemPro.pronum - 1;
              var b = NumUtil.multiplyDecStr(a.toString(), itemPro.fright_once)
                  .toStringAsFixed(2);
              var fright =
                  NumUtil.addDecStr(itemPro.fright_base, b).toStringAsFixed(2);
              _allFreight =
                  NumUtil.addDecStr(_allFreight, fright).toStringAsFixed(2);
            }
          }
        }
      } on Exception catch (e) {}
      return "next";
    }).then((result) {}).catchError((error) {}).whenComplete(() {
      setState(() {});
    });
  }

  _getResult() {
    Future(() {
      StringBuffer sb = StringBuffer();
      _cartBean.data_list.forEach((element) {
        element.sub.forEach((element) {
          if (element.isCheck) {
            sb.write(element.id);
            if (!sb.toString().endsWith(",")) {
              sb.write(",");
            }
          }
        });
      });
      String selectCartIds = sb.toString();
      if (selectCartIds.isEmpty) {
        throw "请勾选要结算的商品";
      }
      selectCartIds = selectCartIds.substring(0, selectCartIds.length - 1);
      return selectCartIds;
    }).then((selectCartIds) {
      var result = App.router.navigateTo(
          context,
          Routes.orderAffirmPage +
              "?cartIds=$selectCartIds&shopType=$shopType");
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
    }).catchError((error) {
      print(error);
      print("cart_error");
      // Toast.toast(context, error.toString());
    });
  }
}
