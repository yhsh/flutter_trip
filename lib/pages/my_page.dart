import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/webview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: WebView(
        url: "https://m.ctrip.com/webapp/myctrip",
        hideAppBar: true,
        backForBid: true,
        statusBarColor: "4c5bca",
      ),
    ));
  }
}
