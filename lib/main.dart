import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop_new/provider/ProviderStore.dart';

import 'main_page.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderStore.init(
        context: context,
        child: Container(
          child: MaterialApp(
            title: 'Flutter',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.lightBlue),
            home: MainPage(),
          ),
        ));
  }
}
