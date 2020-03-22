import 'dart:convert';
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;

//首页json数据接口
const Home_Url = "https://www.devio.org/io/flutter_app/json/home_page.json";

class HomeDao {
  //请求首页接口的方法
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_Url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception("服务器请求失败！");
    }
  }
}
