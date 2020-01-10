import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/common/my_api.dart';
import 'package:flutter_shop_new/http/http_request.dart';
import 'package:flutter_shop_new/page/main/model/hotgoods.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeHotRegion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: postRequest(API_HotGoodListUrl, data: {'page': 1}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = json.decode(snapshot.data.toString());
            HotGoodsModel model = HotGoodsModel.fromJson(data);
            return _hotGood(model.data);
          } else {
            return Center(
              child: SpinKitDoubleBounce(
                color: Colors.blueAccent,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _hotGood(List<HotGoods> hotgoods) {
    return Column(
      children: <Widget>[
        _buildTitle(),
        _buildList(hotgoods),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          )),
      child: Text(
        "火爆专区",
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _buildList(List<HotGoods> hotgoods) {
    List<Widget> listWidget = hotgoods.map((data) {
      return InkWell(
        onTap: _onImageClick(data.goodsId),
        child: Container(
          width: ScreenUtil().setFullWidth(1 / 2) - ScreenUtil().setWidth(4),
          decoration:
              BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
          child: _buildItem(data),
        ),
      );
    }).toList();

    return Wrap(
      spacing: 2,
      children: listWidget,
    );
  }

  Widget _buildItem(HotGoods goods) {
    return Column(
      children: <Widget>[
        Image.network(
          goods.image,
          fit: BoxFit.fill,
        ),
        Text(
          goods.name,
          maxLines: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("¥${goods.mallPrice}"),
            Text(
              "¥${goods.price}",
              style: TextStyle(
                //删除线
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onImageClick(var imgUrl) {
    //TODO...图片点击跳转
  }
}
