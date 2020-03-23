import 'dart:convert';

import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http
        .get("http://www.devio.org/io/flutter_app/json/travel_page.json");
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print("打印旅拍tab数据$result");
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception("服务器请求失败");
    }
  }
}
