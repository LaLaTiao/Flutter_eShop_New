import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/common/my_api.dart';
import 'package:flutter_shop_new/http/http_request.dart';
import 'package:flutter_shop_new/page/main/view/home_floor.dart';
import 'package:flutter_shop_new/page/main/view/home_shoper.dart';
import 'package:flutter_shop_new/provider/HotGoodsProvider.dart';
import 'package:flutter_shop_new/provider/ProviderStore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'model/mainpage_content.dart';
import 'view/home_gridview.dart';
import 'view/home_hot.dart';
import 'view/home_recommend.dart';
import 'view/home_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();

  @override
  bool get wantKeepAlive => true;

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

              return SmartRefresher(
                enablePullUp: true,
                controller: _refreshController,
                footer: ClassicFooter(),
                onLoading: _loadMore,
                child: ListView(
                  children: <Widget>[
                    SwiperView(swiperList: model.data.slides),
                    HomeGridView(category: model.data.category),
                    Image.network(model.data.advertesPicture.pICTUREADDRESS),
                    ShoperView(shopInfo: model.data.shopInfo),
                    HomeRecommend(recommend: model.data.recommend),
                    HomeFloors(content: model.data),
                    HomeHotRegion(),
                  ],
                ),
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

  _loadMore() async {
    HotGoodsProvider provider =
        ProviderStore.valueByListen<HotGoodsProvider>(context, false);
    await provider.loadMoreHotRegionData();
    int state = provider.refreshState;
    switch (state) {
      case 1:
        _refreshController.loadComplete();
        break;
      case -1:
        _refreshController.loadFailed();
        break;
      case 2:
        _refreshController.loadNoData();
        break;
    }
  }
}
