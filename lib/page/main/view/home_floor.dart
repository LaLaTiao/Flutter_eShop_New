import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/page/main/model/mainpage_content.dart';

class HomeFloors extends StatelessWidget {
  final MainPageContent content;

  const HomeFloors({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //这个布局的数据结构比较奇葩.
    //是 floor1Pic + floor1(floor1里面又是一个数组)/floor2/floor3 这样的
    return Container(
        height: ScreenUtil().setHeight(2200),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => buildImage(context, index)));
  }

  Widget buildImage(BuildContext context, int index) {
    var imageUrl;
    switch (index) {
      case 0:
        imageUrl = content.floor1Pic.pICTUREADDRESS;
        break;
      case 1:
        imageUrl = content.floor2Pic.pICTUREADDRESS;
        break;
      case 2:
        imageUrl = content.floor3Pic.pICTUREADDRESS;
        break;
    }
    return Container(
      child: Column(
        children: <Widget>[
          buildItem(context, imageUrl, "", 1.0),
          buildFloor(context, index),
        ],
      ),
    );
  }

  Widget buildFloor(BuildContext context, int index) {
    List<dynamic> floor;
    switch (index) {
      case 0:
        floor = content.floor1;
        break;
      case 1:
        floor = content.floor2;
        break;
      case 2:
        floor = content.floor3;
        break;
    }
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            buildItem(context, floor.elementAt(0).image,
                floor.elementAt(0).goodsId, 1 / 2),
            buildItem(context, floor.elementAt(1).image,
                floor.elementAt(0).goodsId, 1 / 2),
          ],
        ),
        Column(
          children: <Widget>[
            buildItem(context, floor.elementAt(2).image,
                floor.elementAt(0).goodsId, 1 / 2),
            buildItem(context, floor.elementAt(3).image,
                floor.elementAt(0).goodsId, 1 / 2),
            buildItem(context, floor.elementAt(4).image,
                floor.elementAt(0).goodsId, 1 / 2),
          ],
        ),
      ],
    );
  }

  Widget buildItem(
      BuildContext context, String imgUrl, String imgID, double width) {
    return Container(
      width: ScreenUtil().setFullWidth(width),
      child: InkWell(
        onTap: onImgTap(context, imgID),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  onImgTap(BuildContext context, String imgID) {
    //TODO....
    if (imgID.isNotEmpty) {
      //图片点击,根据id跳转
    }
  }
}
