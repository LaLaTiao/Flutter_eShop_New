import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_new/common/my_api.dart';
import 'package:flutter_shop_new/http/http_request.dart';
import 'package:flutter_shop_new/page/main/model/hotgoods.dart';

class HotGoodsProvider with ChangeNotifier {
  int _page = 0;
  List<HotGoods> hotGoods = List();

  // 0 -> 默认
  // 1 -> 加载成功
  // 2 -> 无数据
  // -1 -> 加载失败
  int refreshState;

  addGoods(List<HotGoods> _data) {
    hotGoods.addAll(_data);
    notifyListeners();
  }

  loadMoreHotRegionData() async {
    print("调用一次,当前第$_page页");
    await postRequest(API_HotGoodListUrl, data: {'page': _page}).then((val) {
      Map<String, dynamic> map = json.decode(val.toString());
      HotGoodsModel model = HotGoodsModel.fromJson(map);
      if (model.data != null && model.data.isNotEmpty) {
        _page++;
        addGoods(model.data);
        refreshState = 1;
      } else {
        refreshState = 2;
      }
    });
  }
}
