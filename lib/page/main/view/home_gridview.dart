import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/page/main/model/mainpage_content.dart';

class HomeGridView extends StatelessWidget {
  final List<Category> category;

  const HomeGridView({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (category.length > 10) {
      category.removeRange(10, category.length);
    }

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(280),
      child: GridView.count(
        crossAxisCount: 5,
        padding: const EdgeInsets.all(4.0),
        childAspectRatio: 1.0,
        //不允许这个GridView滑动
        physics: NeverScrollableScrollPhysics(),
        children: category.map((item) {
          return _gridItem(item);
        }).toList(),
      ),
    );
  }

  Widget _gridItem(Category item) {
    return InkWell(
      onTap: _onGridItemClick(item.mallCategoryId),
      child: Column(
        children: <Widget>[
          Image.network(
            item.image,
            fit: BoxFit.contain,
            width: ScreenUtil().setWidth(95),
            height: ScreenUtil().setHeight(95),
          ),
          Text(item.mallCategoryName)
        ],
      ),
    );
  }

  _onGridItemClick(String categoryId) {
    //TODO...click
  }
}
