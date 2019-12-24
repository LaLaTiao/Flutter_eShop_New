import 'package:flutter/material.dart';
import 'package:flutter_shop_new/page/cart/cart_page.dart';
import 'package:flutter_shop_new/page/category/category_page.dart';
import 'package:flutter_shop_new/page/main/home_page.dart';
import 'package:flutter_shop_new/page/mine/mine_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  final List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(icon: Icon(Icons.donut_small), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.donut_small), title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(Icons.donut_small), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(Icons.donut_small), title: Text('我的')),
  ];

  final List<Widget> tabPages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        items: tabs,
        onTap: (index) {
          if (_index != index) {
            setState(() {
              _index = index;
            });
          }
        },
      ),
      body: IndexedStack(
        index: _index,
        children: tabPages,
      ),
    );
  }
}
