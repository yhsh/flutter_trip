import 'dart:convert';

import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel searchModel = SearchModel.fromJson(result);
      //当输入的内容和服务器返回的内容一致才渲染
      searchModel.keyword = text;
      return searchModel;
    } else {
      throw Exception("服务器请求失败");
    }
  }
}
