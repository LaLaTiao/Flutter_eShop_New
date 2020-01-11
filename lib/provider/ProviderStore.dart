import 'package:flutter/material.dart';
import 'package:flutter_shop_new/provider/HotGoodsProvider.dart';
import 'package:provider/provider.dart';

class ProviderStore {
  static BuildContext context;

  static init({context, child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HotGoodsProvider()),
      ],
      child: child,
    );
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context) {
    return Provider.of(context);
  }

  static T valueByListen<T>(context, needListen) {
    return Provider.of(context, listen: needListen);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}
