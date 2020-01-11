import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/page/main/model/hotgoods.dart';
import 'package:flutter_shop_new/provider/HotGoodsProvider.dart';
import 'package:provider/provider.dart';

class HomeHotRegion extends StatelessWidget {
  List<Widget> listWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTitle(),
          _buildList(context),
        ],
      ),
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

  Widget _buildList(BuildContext context) {
    listWidget = _getGoods(context);

    if (listWidget != null && listWidget.isNotEmpty) {
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text("");
    }
  }

  List<Widget> _getGoods(BuildContext context) {
    List<HotGoods> data = Provider.of<HotGoodsProvider>(context).hotGoods;
    if (data != null && data.isNotEmpty) {
      return data.map((data) {
        return InkWell(
          onTap: _onImageClick(data.goodsId),
          child: Container(
            width: ScreenUtil().setFullWidth(1 / 2) - ScreenUtil().setWidth(4),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey)),
            child: _buildItem(data),
          ),
        );
      }).toList();
    }
    return null;
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
