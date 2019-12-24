import 'package:flutter/material.dart';
import 'package:flutter_shop_new/page/main/model/mainpage_content.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoperView extends StatelessWidget {
  final ShopInfo shopInfo;

  const ShoperView({Key key, this.shopInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _callPhone,
        child: Image.network(shopInfo.leaderImage),
      ),
    );
  }

  _callPhone() async {
    String tel = 'tel:' + shopInfo.leaderPhone;
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch $tel';
    }
  }
}
