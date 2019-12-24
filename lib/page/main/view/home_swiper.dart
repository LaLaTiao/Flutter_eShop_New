import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop_new/page/main/model/mainpage_content.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwiperView extends StatelessWidget {
  final List<Slides> swiperList;

  const SwiperView({Key key, this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _index = 0;

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperList.length,
        itemBuilder: (BuildContext context, int index) {
          _index = index;
          return Image.network(
            swiperList.elementAt(index).image,
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
        onTap: _onBannerClick(swiperList.elementAt(_index).goodsId),
      ),
    );
  }

  _onBannerClick(String goodId) {
    //TODO...click事件
  }
}
