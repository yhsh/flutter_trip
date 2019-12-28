import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = new PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final _defaultColor = Colors.grey;
    final _pressColor = Colors.blue;
    int _currentIndex = 0;
    return Scaffold(
        body: PageView(controller: _controller, children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
        ]),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
              print("打印位置" + _currentIndex.toString());
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: _defaultColor,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: _pressColor,
                  ),
                  title: Text(
                    "首页",
                    style: TextStyle(
                        color:
                            _currentIndex != 0 ? _defaultColor : _pressColor),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: _defaultColor,
                  ),
                  activeIcon: Icon(
                    Icons.search,
                    color: _pressColor,
                  ),
                  title: Text(
                    "搜索",
                    style: TextStyle(
                        color:
                            _currentIndex != 1 ? _defaultColor : _pressColor),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera_alt,
                    color: _defaultColor,
                  ),
                  activeIcon: Icon(
                    Icons.camera_alt,
                    color: _pressColor,
                  ),
                  title: Text(
                    "旅拍",
                    style: TextStyle(
                        color:
                            _currentIndex != 2 ? _defaultColor : _defaultColor),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    color: _defaultColor,
                  ),
                  activeIcon: Icon(
                    Icons.account_circle,
                    color: _pressColor,
                  ),
                  title: Text(
                    "我的",
                    style: TextStyle(
                        color:
                            _currentIndex != 3 ? _defaultColor : _pressColor),
                  ))
            ]));
  }
}
