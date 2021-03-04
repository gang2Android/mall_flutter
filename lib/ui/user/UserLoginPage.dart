import 'package:flutter/material.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/ui/user/UserRepository.dart';
import 'package:flutter_app_01/utils/Toast.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  FocusNode _nextInputNode = FocusNode();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  bool _nameNoEmpty = false;
  bool _pwdNoEmpty = false;

  UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nextInputNode.dispose();
    _nameController.dispose();
    _pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: _bodyView(),
      resizeToAvoidBottomInset: false,
    );
  }

  _bodyView() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 100.0),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: _nameClear(),
              contentPadding: const EdgeInsets.all(10.0),
              icon: Icon(Icons.person),
              labelText: '请输入你的用户名)',
              // helperText: '请输入注册的手机号',
            ),
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(_nextInputNode),
            autofocus: false,
            onChanged: (value) {
              print(value);
              _nameNoEmpty = value.isNotEmpty;
              setState(() {});
            },
          ),
          Container(height: 10.0),
          TextField(
            controller: _pwdController,
            focusNode: _nextInputNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              suffixIcon: _pwdClear(),
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.lock),
              labelText: '请输入密码)',
            ),
            obscureText: true,
            onChanged: (value) {
              print(value);
              _pwdNoEmpty = value.isNotEmpty;
              setState(() {});
            },
          ),
          Container(height: 100.0),
          ButtonTheme(
            child: RaisedButton(
              onPressed: (_nameNoEmpty && _pwdNoEmpty) ? _login : null,
              child: Text('登录'),
              color: Color(App.appColor),
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            ),
            minWidth: MediaQuery.of(context).size.width * 0.8,
          ),
        ],
      ),
    );
  }

  _nameClear() {
    if (_nameNoEmpty) {
      return InkWell(
        child: Icon(Icons.clear),
        onTap: () {
          _nameController.clear();
          _nameNoEmpty = false;
          setState(() {});
        },
      );
    }
    return null;
  }

  _pwdClear() {
    if (_pwdNoEmpty) {
      return InkWell(
        child: Icon(Icons.clear),
        onTap: () {
          _pwdController.clear();
          _pwdNoEmpty = false;
          setState(() {});
        },
      );
    }
    return null;
  }

  _login() {
    String name = _nameController.text.toString();
    if (name.isEmpty) {
      return;
    }
    String pwd = _pwdController.text.toString();
    if (pwd.isEmpty) {
      return;
    }
    _userRepository.userLogin(name, pwd, () {
      Navigator.of(context).pop(true);
    }, (error) {
      Toast.toast(context, error, isError: true);
    });
  }
}
