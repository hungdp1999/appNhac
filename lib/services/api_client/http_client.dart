import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();

  static HttpClient instance = HttpClient();

  factory HttpClient() {
    return _instance;
  }

  HttpClient._internal();

  var dio = Dio();

  Future get(String path, {Map<String, dynamic>? queries}) async {
    try {
      Response response =
          await dio.get(path, queryParameters: queries ?? <String, dynamic>{});
      debugPrint(response.data.toString());
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future post(String path, {dynamic data}) async {
    try {
      Response response = await dio.post(path, data: data);
      debugPrint(response.data.toString());
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future put() async {}

  void dispose() {
    dio.close();
  }
}
