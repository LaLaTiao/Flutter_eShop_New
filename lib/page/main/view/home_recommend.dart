import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/page/main/model/mainpage_content.dart';

class HomeRecommend extends StatelessWidget {
  final List<Recommend> recommend;

  const HomeRecommend({Key key, this.recommend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _recommendTitle(),
          _recommendList(),
        ],
      ),
    );
  }

  Widget _recommendTitle() {
    return Container(
      margin: EdgeInsets.only(left: 8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Text('商品推荐'),
    );
  }

  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(320),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommend.length,
          itemBuilder: (BuildContext context, int index) {
            return _recommendItem(index);
          }),
    );
  }

  Widget _recommendItem(int index) {
    return Container(
      height: ScreenUtil().setHeight(320),
      width: ScreenUtil().setWidth(250),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: InkWell(
        onTap: _onRecommendClick(recommend.elementAt(index).goodsId),
        child: Column(
          children: <Widget>[
            Image.network(
              recommend.elementAt(index).image,
              fit: BoxFit.fill,
            ),
            Text(
              recommend.elementAt(index).goodsName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(4, 2, 4, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "¥${recommend.elementAt(index).mallPrice}",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "¥${recommend.elementAt(index).price}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      //删除线
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onRecommendClick(String goodId) {
    //TODO...click事件
  }
}
