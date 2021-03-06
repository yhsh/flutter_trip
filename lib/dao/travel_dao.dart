import 'dart:convert';

import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/utils/log_util.dart';
import 'package:http/http.dart' as http;

///旅拍页接口
var Params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {'cid': "09031014111431397988"},
  "contentType": "json"
};

class TravelDao {
  static Future<TravelItemModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Params['groupChannelCode'] = groupChannelCode;
    Map paramsMap = Params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    var response = await http.post(url, body: jsonEncode(Params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      LogUtil.d("打印旅拍服务器数据$result");
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception("请求服务器失败！");
    }
  }
}
