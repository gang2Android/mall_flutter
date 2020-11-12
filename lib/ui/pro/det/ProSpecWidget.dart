import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/SingleChooseWidget.dart';
import 'package:flutter_app_01/ui/pro/det/CountWidget.dart';
import 'package:flutter_app_01/ui/pro/det/ProDetailBean.dart';

class ProSpecWidget extends StatefulWidget {
  final ProDetailBean proDetailBean;

  ProSpecWidget({Key key, this.proDetailBean}) : super(key: key);

  @override
  _ProSpecWidgetState createState() => _ProSpecWidgetState();
}

class _ProSpecWidgetState extends State<ProSpecWidget> {
  ProDetailBean _proDetailBean;
  ProSpecBean specBean;
  Map<String, List<ProSpecAttrItemBean>> attrs = Map();

  List<ProSpecAttrItemBean> _selectSpecs = List();
  List<String> _selectSpecName = List();
  ProSpecAttrPathBean _selectSpec;
  int _num = 1;

  @override
  void initState() {
    super.initState();
    _proDetailBean = widget.proDetailBean;
    specBean = _proDetailBean.guige;

    Future<String>(() {
      for (int i = 0; i < specBean.stockname.length; i++) {
        List<ProSpecAttrItemBean> items = List();
        specBean.attr["attr${i + 1}"].forEach((value) {
          var item = ProSpecAttrItemBean.fromJson(value);
          if (_exitPath(item.id)) {
            if (items.length == 0) {
              _selectSpecs.add(item);
              _selectSpecName.add(item.attr_name);
            }
            items.add(item);
          }
        });
        attrs["$i"] = items;
      }
      print("init");
      return "init";
    }).whenComplete(() {
      print("whenComplete");
      _changeSelect();
    });
  }

  bool _exitPath(String id) {
    bool isExit = false;
    for (int i = 0; i < specBean.attr_path.length; i++) {
      var element = specBean.attr_path[i];
      if (!isExit) {
        if (element.attr_path.contains(id)) {
          isExit = true;
          break;
        }
      }
    }
    return isExit;
  }

  _changeSelect({bool isState = true}) {
    print("_changeSelect");
    Future<String>(() {
      _selectSpecName.clear();
      StringBuffer sb = StringBuffer();
      _selectSpecs.forEach((element) {
        _selectSpecName.add(element.attr_name);
        sb.write(element.id);
        if (!sb.toString().endsWith(",")) {
          sb.write(",");
        }
      });
      String selectSpecIds = sb.toString();
      selectSpecIds = selectSpecIds.substring(0, selectSpecIds.length - 1);
      for (int i = 0; i < specBean.attr_path.length; i++) {
        ProSpecAttrPathBean item = specBean.attr_path[i];
        if (item.attr_path == selectSpecIds) {
          _selectSpec = item;
          String info = _selectSpecName.toString();
          info = info.replaceAll("[", "");
          info = info.replaceAll("]", "");
          _selectSpec.name = info;
          _selectSpec.num = _num;
          break;
        }
      }
      if (isState) {
        setState(() {});
      }
      print("change");
      return "change";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (attrs.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            _specTopView(),
            Expanded(
              child: Container(),
            ),
            _specBottomView(),
          ],
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          _specTopView(),
          Expanded(
            child: _specContentView(),
          ),
          _specBottomView(),
        ],
      ),
    );
  }

  _specTopView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            _proDetailBean.imgalbum[0],
            width: 100.0,
            height: 100.0,
          ),
          Expanded(
            child: Container(
              height: 100.0,
              margin: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "会员价：" + (_selectSpec == null ? "0.00" : _selectSpec.price),
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                  Container(height: 5.0),
                  Text(
                    "库存${(_selectSpec == null ? "0" : _selectSpec.kucun)}件",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  Container(height: 5.0),
                  Text(
                    "已选择：" + _selectSpecName.toString(),
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _selectSpec.isClose = true;
              Navigator.of(context).pop(_selectSpec);
            },
            child: Icon(Icons.close, size: 30.0),
          ),
        ],
      ),
    );
  }

  _specContentView() {
    return ListView.builder(
      itemCount: specBean.stockname.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(top: 2.0),
          padding: const EdgeInsets.all(5.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${specBean.stockname[index].name}",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              SingleChooseWidget(
                list: attrs["$index"],
                onChange: (item) {
                  print("SingleChooseWidget-${item.toString()}");
                  _selectSpecs[index] = item;
                  _changeSelect();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _specBottomView() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                "购买数量：",
                style: TextStyle(fontSize: 14.0, color: Colors.black),
              ),
              Expanded(child: Container()),
              CountView(
                num: 1,
                max: 100,
                callBack: (num) {
                  _num = num;
                  _selectSpec.num = _num;
                },
              ),
            ],
          ),
        ),
        InkWell(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              color: Color(App.appColor),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Text(
              "确定",
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
          onTap: () {
            if (_selectSpec == null) {
              Toast.toast(context, "请选择商品属性");
              return;
            }
            _selectSpec.isClose = false;
            Navigator.of(context).pop(_selectSpec);
          },
        ),
      ],
    );
  }
}
