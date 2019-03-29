import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:jmaryshop/model/HomeModel.dart';

String baseURL = 'http://dev.boleci.com/ws';

Future<HomeModel> getShowCase() async {
  Map<String, dynamic> body = {
    'keyword': 'get_item_with_page_imagemultiple_xamarin',
    'shop_id': '57c95036ee5da8dc3c000000',
    'user_id': '1',
    'offset': '1',
    'limit': '10',
  };
  return http.post(baseURL, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print('http_showcase ' + response.body.toString());
    return HomeModel.fromJson(json.decode(response.body));
  });
}
