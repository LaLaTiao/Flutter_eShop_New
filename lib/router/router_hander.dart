import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_new/page/main/home_page.dart';
import 'package:flutter_shop_new/page/cart/cart_page.dart';
import 'package:flutter_shop_new/page/category/category_page.dart';
import 'package:flutter_shop_new/page/detail/detail_page.dart';
import 'package:flutter_shop_new/page/mine/mine_page.dart';

//主页
Handler homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

//商品分类
Handler cartgoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CategoryPage();
});

//商品详情
Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DetailPage();
});

//购物车列表
Handler cartHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartPage();
});

//个人中心--关于页面
Handler mineHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MinePage();
});
