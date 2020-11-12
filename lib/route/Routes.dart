import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import './RouteHandlers.dart';

class Routes {
  static String root = '/'; //根目录
  static String h5Page = '/h5';
  static String setPage = '/set';
  static String aboutPage = '/set/about';

  static String searchPage = '/search';
  static String proListPage = '/pro/list';
  static String proDetailPage = '/pro/detail';

  static String orderAffirmPage = '/order/affirm';
  static String orderPayPage = '/order/pay';
  static String orderListPage = '/order/list';
  static String orderDetailPage = '/order/det';

  static String addressListPage = '/address/list';
  static String addressDetailPage = '/address/det';

  static String userLoginPage = '/user/login';
  static String collectListPage = '/user/collect';
  static String userSharePage = '/user/share';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
    });
    router.define(h5Page, handler: h5PageHandler);
    router.define(setPage, handler: setPageHandler);
    router.define(aboutPage, handler: aboutPageHandler);

    router.define(searchPage, handler: searchPageHandler);
    router.define(proListPage, handler: proListPageHandler);
    router.define(proDetailPage, handler: proDetailPageHandler);

    router.define(orderAffirmPage, handler: orderAffirmPageHandler);
    router.define(orderPayPage, handler: orderPayPageHandler);
    router.define(orderListPage, handler: orderListPageHandler);
    router.define(orderDetailPage, handler: orderDetailPageHandler);

    router.define(addressListPage, handler: addressListPageHandler);
    router.define(addressDetailPage, handler: addressDetailPageHandler);

    router.define(userLoginPage, handler: userLoginPageHandler);
    router.define(collectListPage, handler: collectListPageHandler);
    router.define(userSharePage, handler: userSharePageHandler);
  }
}
