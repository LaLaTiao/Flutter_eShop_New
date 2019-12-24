import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_shop_new/common/my_api.dart';

BaseOptions options = BaseOptions(
  baseUrl: API_BaseUrl,
  connectTimeout: 6000,
  receiveTimeout: 4000,
  contentType: ContentType.parse('application/x-www-form-urlencoded'),
);

Future request(method, url, {data}) async {
  options.method = method;
  Dio dio = Dio(options);
  Response response;

  try {
    response =
        data == null ? await dio.post(url) : await dio.post(url, data: data);
    return response;
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
    } else {
      print(e.request);
      print(e.message);
    }
  }
}

Future postRequest(url, {data}) async {
  return request('POST', url, data: data);
}

Future getRequest(url, {data}) async {
  return request('GET', url, data: data);
}

Future multipleRequest(url, data, url1, data1) async {
  options.method = 'POST';
  Dio dio = Dio(options);
  var response;

  try {
    response = await Future.wait([
      dio.post(url, data: data),
      dio.post(url1, data: data1),
    ]);

    return response;
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
    } else {
      print(e.request);
      print(e.message);
    }
  }
}
