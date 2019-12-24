import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/common/my_api.dart';
import 'package:flutter_shop_new/http/http_request.dart';
import 'package:flutter_shop_new/page/main/view/home_shoper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'model/mainpage_content.dart';
import 'view/home_gridview.dart';
import 'view/home_swiper.dart';
import 'view/home_recommend.dart';
import 'view/home_hot.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    int _pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(title: Text('这是首页')),
      body: Container(
        child: FutureBuilder(
          future: postRequest(API_HomePageUrl,
              data: {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = json.decode(snapshot.data.toString());
              MainPageContentModel model = MainPageContentModel.fromJson(data);

              return ListView(
                children: <Widget>[
                  SwiperView(swiperList: model.data.slides),
                  HomeGridView(category: model.data.category),
                  Image.network(model.data.advertesPicture.pICTUREADDRESS),
                  ShoperView(shopInfo: model.data.shopInfo),
                  HomeRecommend(recommend: model.data.recommend),
                ],
              );
            } else {
              return Center(
                child: SpinKitDoubleBounce(
                  color: Colors.blueAccent,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
