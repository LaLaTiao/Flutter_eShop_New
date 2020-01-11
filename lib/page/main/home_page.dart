import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_new/common/my_api.dart';
import 'package:flutter_shop_new/http/http_request.dart';
import 'package:flutter_shop_new/page/main/model/hotgoods.dart';
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
  var page = 1;
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
                enablePullDown: false,
                controller: _refreshController,
                footer: _footer(),
                onLoading: _loadMoreHotRegionData,
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

  _loadMoreHotRegionData() async {
    postRequest(API_HotGoodListUrl, data: {'page': page}).then((val) {
      Map<String, dynamic> map = json.decode(val.toString());
      HotGoodsModel model = HotGoodsModel.fromJson(map);
      if (model.data.isNotEmpty) {
        setState(() {
          page++;
        });
        //TODO...为什么这里一定要传一个 listen:false.
        ProviderStore.valueByListen<HotGoodsProvider>(context, false)
            .addGoods(model.data);
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    });
  }

  Widget _footer() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("上拉加载");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("加载失败！点击重试！");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("松手,加载更多!");
        } else {
          body = Text("没有更多数据了!");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
