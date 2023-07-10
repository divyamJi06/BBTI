import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

/// More examples see https://github.com/cfug/dio/blob/main/example
class ApiConnect {
  static Future<String> hitApiPost(String url, Map<String, dynamic> params) async {
    final dio = Dio();
    final response = await dio.post(
      url,
      data: (params),
    );
    return response.data;
  }

  static Future<String> hitApiGet(url) async {
    final dio = Dio();
    final response = await dio.get(url);
    return response.data;
  }
}