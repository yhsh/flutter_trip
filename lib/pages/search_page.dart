import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("搜索", style: TextStyle(fontSize: 18)),
        ),
        body: Column(
          children: <Widget>[
            SearchBar(
              hideLeft: true,
              defaultText: "测试数据",
              hint: "请输入文字搜索",
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ],
        ));
  }

  void _onTextChange(text) {}
}
