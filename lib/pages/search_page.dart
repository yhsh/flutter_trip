import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/webview.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
String showText = "";
const String URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key,
      this.hideLeft,
      this.searchUrl = URL,
      this.keyword,
      this.hint = "输入关键字查询"})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        _appBar(),
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position);
                  }),
            )),
        Text(showText),
      ],
    ));
  }

  void _onTextChange(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    SearchDao.fetch(url, text).then((SearchModel model) {
      //当输入的内容和服务器返回的一致的时候才进行展示结果数据
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  //appBar渐变遮罩背景
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem searchItem = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebView(
              url: searchItem.url,
              title: "详情",
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1),
              child: Image(image: AssetImage(_typeImage(searchItem.type))),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(searchItem),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: _subTitle(searchItem),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _typeImage(String type) {
    if (type == null) return "images/type_travelgroup.png";
    String path = "travelgroup";
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return "images/type_$path.png";
  }

  _title(SearchItem searchItem) {
    if (searchItem == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordSpan(searchItem.word, searchModel.keyword));
    spans.add(
      TextSpan(
          text: " " + searchItem.districtName ??
              "" + " " + searchItem.zoneName ??
              "",
          style: TextStyle(fontSize: 14, color: Colors.grey)),
    );
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem searchItem) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: searchItem.price ?? "",
          style: TextStyle(fontSize: 14, color: Colors.orange)),
      TextSpan(
          text: "  " + (searchItem.star ?? ""),
          style: TextStyle(fontSize: 12, color: Colors.grey))
    ]));
  }

  _keywordSpan(String word, String keyword) {
    List<TextSpan> span = [];
    if (word == null || word.length == 0) return span;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 14, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 14, color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        span.add(TextSpan(text: keyword, style: keywordStyle));
      }
      if (arr[i] != null && arr[i].length > 0) {
        span.add(TextSpan(text: arr[i], style: normalStyle));
      }
    }
    return span;
  }
}
