import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/address/AddressBean.dart';
import 'package:flutter_app_01/ui/address/AddressRepository.dart';
import 'package:flutter_app_01/utils/Toast.dart';
import 'package:flutter_app_01/widget/DefaultAppBar.dart';

class AddressDetailPage extends StatefulWidget {
  final bool isAdd;
  final String addressInfo;

  AddressDetailPage({Key key, this.isAdd = true, this.addressInfo = ""})
      : super(key: key);

  @override
  _AddressDetailPageState createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  AddressRepository _addressRepository = AddressRepository();
  AddressBean _addressBean;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  bool isDefault = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isAdd) {
      if (widget.addressInfo.isNotEmpty) {
        var jsonMap = json.decode(widget.addressInfo);
        _addressBean = AddressBean.fromJson(jsonMap);

        _nameController.text = _addressBean.receiveName;
        _mobileController.text = _addressBean.mobile;
        _addressController.text = _addressBean.address;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("收货地址"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("收货人："),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5.0),
                      ),
                      controller: _nameController,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("手机号："),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5.0),
                      ),
                      controller: _mobileController,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("地区："),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      child: Padding(
                        child: Text("点击选择地区"),
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 10.0,
                          bottom: 10.0,
                        ),
                      ),
                      onTap: (){
                        print("11");
                      },
                    ),
                  ),
                  Padding(
                    child: Icon(Icons.arrow_right),
                    padding: const EdgeInsets.only(right: 10.0),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("详细地址："),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5.0),
                      ),
                      controller: _addressController,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Text("设置为默认地址："),
                  Expanded(child: Container()),
                  Switch(
                    value: isDefault,
                    onChanged: (value) {
                      this.isDefault = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: Container(height: 10.0)),
            SliverToBoxAdapter(
              child: ButtonTheme(
                child: RaisedButton(
                  onPressed: () {
                    _saveAddress();
                  },
                  child: Text('保存'),
                  color: Color(App.appColor),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                ),
                minWidth: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveAddress() {
    String receiveName = _nameController.value.text;
    String mobile = _mobileController.value.text;
    String address = _addressController.value.text;
    String province = "河南省";
    String city = "郑州市";
    String county = "金水区";
    String town = "经八路街道";
    String isDefaultStr = isDefault ? "1" : "0";
    if (widget.isAdd) {
      _addressBean = AddressBean(null, null, receiveName, mobile, province,
          city, county, town, address, isDefaultStr);
      _addressRepository.addAddress(
        _addressBean,
        (data) {
          Toast.toast(context, data);
          Navigator.of(context).pop(true);
        },
        (error) {
          Toast.toast(context, error, isError: true);
        },
      );
    } else {
      _addressBean.receiveName = receiveName;
      _addressBean.mobile = mobile;
      _addressBean.address = address;
      _addressBean.province = province;
      _addressBean.city = city;
      _addressBean.county = county;
      _addressBean.town = town;
      _addressBean.isDefault = isDefaultStr;

      _addressRepository.updateAddress(_addressBean, (data) {
        Toast.toast(context, data);
        Navigator.of(context).pop(true);
      }, (error) {
        Toast.toast(context, error, isError: true);
      });
    }
  }
}
