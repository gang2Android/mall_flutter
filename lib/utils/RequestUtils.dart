import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_01/App.dart';
import 'package:flutter_app_01/utils/DioLogInterceptor.dart';
import 'package:flutter_app_01/utils/DioResponseInterceptors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestUtils {
  final String tag = "RequestUtils";

  static RequestUtils _instance;

  factory RequestUtils() => _instance;

  static RequestUtils get instance => _instance;

  Dio dio;
  Options options;
  CancelToken cancelToken;

  RequestUtils._internal() {
    dio = Dio();
    dio.options.baseUrl = "";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;

    dio.interceptors.add(DioLogInterceptor());
    dio.interceptors.add(DioResponseInterceptors());

    options = Options();
    options.contentType = "application/x-www-form-urlencoded";

    cancelToken = CancelToken();
  }

  static RequestUtils getInstance() {
    if (_instance == null) {
      _instance = RequestUtils._internal();
    }
    return _instance;
  }

  cancelAll() {
    cancelToken.cancel();
  }

  Future<Map<String, dynamic>> getOfAwait(String url,
      {String successStatus = "1", bool isLogin = false}) async {
    Map<String, dynamic> result = Map<String, dynamic>();
    try {
      if (isLogin) {
        if (App.token.isEmpty) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          String token = sp.getString("token");
          String memToken = sp.getString("memToken");
          App.token = token;
          App.token_mem = memToken;
        }
        if (url.startsWith(App.DOMAIN_API)) {
          options.headers["cookiew"] = App.token;
        } else {
          options.headers["cookiew"] = App.token_mem;
        }
      } else {
        if (options.headers.containsKey("cookiew")) {
          options.headers.remove("cookiew");
        }
      }
      var response =
          await dio.get(url, options: options, cancelToken: cancelToken);
      String dataStr = json.encode(response.data);
      Map<String, dynamic> data = json.decode(dataStr);
      if (data == null || data['status'].toString() != successStatus) {
        result["msg"] = data["msg"];
      } else {
        if (data["data"].toString().length < 4) {
          result["msg"] = data["msg"];
        } else {
          result["hint"] = data["msg"];
          result["data"] = data["data"];
        }
      }
    } catch (e) {
      result["msg"] = e.toString();
    }
    return result;
  }

  get(String url, Function success, Function error) async {
    try {
      var response =
          await dio.get(url, options: options, cancelToken: cancelToken);
      String dataStr = json.encode(response.data);
      Map<String, dynamic> data = json.decode(dataStr);
      if (data == null || data['status'] != "1") {
        error(data["msg"]);
      } else {
        success(data["data"]);
      }
    } catch (e) {
      print(e);
      error(e.toString());
    }
  }

  Future<void> post(String url, {data}) async {
    try {
      var response = await dio.post(url,
          options: options, data: data, cancelToken: cancelToken);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<Map<String, dynamic>> postOfAwait(String url,
      {params, successStatus = "1", bool isLogin = false}) async {
    Map<String, dynamic> result = Map<String, dynamic>();
    try {
      if (isLogin) {
        if (App.token.isEmpty) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          String token = sp.getString("token");
          String memToken = sp.getString("memToken");
          App.token = token;
          App.token_mem = memToken;
        }
        if (url.startsWith(App.DOMAIN_API)) {
          options.headers["cookiew"] = App.token;
          options.headers["cookiew2"] = App.token_mem;
        } else {
          options.headers["cookiew"] = App.token_mem;
          options.headers["cookiew2"] = App.token_mem;
        }
      } else {
        if (options.headers.containsKey("cookiew")) {
          options.headers.remove("cookiew");
        }
        if (options.headers.containsKey("cookiew2")) {
          options.headers.remove("cookiew2");
        }
      }
      var response = await dio.post(url,
          options: options, data: params, cancelToken: cancelToken);
      String dataStr = json.encode(response.data);
      Map<String, dynamic> data = json.decode(dataStr);
      if (data == null || data['status'].toString() != successStatus) {
        result["msg"] = data["msg"];
      } else {
        if (data["data"].toString().length < 4) {
          result["msg"] = data["msg"];
        } else {
          result["hint"] = data["msg"];
          result["data"] = data["data"];
        }
      }
    } catch (e) {
      result["msg"] = e.toString();
    }
    return result;
  }
}
