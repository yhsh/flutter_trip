import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

//使用SingleTickerProviderStateMixin报错如下：解决办法使用TickerProviderStateMixin即可解决
//I/flutter (23314):打印异常_TravelPageState is a SingleTickerProviderStateMixin but multiple tickers were created.
//I/flutter (23314): A SingleTickerProviderStateMixin can only be used as a TickerProvider once.
//I/flutter (23314): If a State is used for multiple AnimationController objects, or if it is passed to other objects and those objects might use it more than one time in total, then instead of mixing in a SingleTickerProviderStateMixin, use a regular TickerProviderStateMixin.

//    with SingleTickerProviderStateMixin {
class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print("打印异常$e");
    });
  }

  @override
  void dispose() {
    super.dispose();
    //回收
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30),
          child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((TravelTab tab) {
                return Tab(
                  text: tab.labelName,
                );
              }).toList()),
        ),
        Flexible(
          child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab) {
                return Text(tab.labelName);
              }).toList()),
        )
      ],
    ));
  }
}
