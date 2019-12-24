import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'router_hander.dart';

class Routers {
  static String root = "/";

  //首页
  static String homePage = '/home';

  //商品详情
  static String detailsPage = '/detail';

  //分类
  static String cartgoryPage = '/cartgory';

  //购物车
  static String cartPage = '/cart';

  //个人中心
  static String minePage = '/mine';

  static void configRouters(Router router) {
    //路由跳转,找不到对应页面处理.
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
      //TODO...后续可以统一搞一个 商品不存在的页面.
      print('页面不存在!!!');
    });

    //注册!!!
    router.define(homePage, handler: homeHandler);
    router.define(detailsPage, handler: detailHandler);
    router.define(cartgoryPage, handler: cartgoryHandler);
    router.define(cartPage, handler: cartHandler);
    router.define(minePage, handler: mineHandler);
  }
}
