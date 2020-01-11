import 'package:flutter/material.dart';
import 'package:flutter_shop_new/page/main/model/hotgoods.dart';

class HotGoodsProvider with ChangeNotifier {
  List<HotGoods> hotGoods;

  void addGoods(List<HotGoods> data) {
    if (hotGoods == null) {
      hotGoods = List();
    }
    hotGoods.addAll(data);
    notifyListeners();
  }
}
