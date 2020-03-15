import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/HomeDao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

const APP_BAR_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrl = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  String resultString = "";

  _onScroller(offset) {
//    print(offset);
    if (offset > 100) {
      offset = 100;
    } else if (offset <= 0) {
      offset = 0;
    }
    setState(() {
      appBarAlpha = offset / APP_BAR_OFFSET;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  //加载首页数据的方法
  /* void loadData() {
    HomeDao.fetch().then((result) {
      setState(() {
        resultString = json.encode(result);
      });
    }).catchError((e) {
      setState(() {
        resultString = e.toString();
      });
    });
  } */
  //加载首页数据的方法
  void loadData() async {
    try {
      HomeModel homeModel = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(homeModel.config);
        localNavList = homeModel.localNavList;
        gridNavModel = homeModel.gridNav;
        subNavList = homeModel.subNavList;
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
        print(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
                //移除状态栏关键属性
                removeTop: true,
                context: context,
                //监听ListView滚动的方法
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroller(scrollNotification.metrics.pixels);
                    }
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 170,
                        child: Swiper(
                          itemCount: _imageUrl.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrl[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
//                  GridNav(gridNavModel: null, name: "显示数据666"),
                      Padding(
                          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: LocalNav(localNavList: localNavList)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: GridNav(gridNavModel: gridNavModel)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: SubNav(subNavList: subNavList)),
                      Container(
                        height: 800,
                        child: ListTile(
                          title: Text(resultString),
                        ),
                      )
                    ],
                  ),
                )),
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.greenAccent),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("首页"),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
