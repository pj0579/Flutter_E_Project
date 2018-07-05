import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cate_listview.dart';

const List<String> _allPages = const <String>[
  "水产海鲜",
  "米面粮油",
  "肉禽蛋奶",
  "水果蔬菜",
  "进口零食",
  "休闲零食",
];
const List<String> _allId = const <String>[
  "327",
  "326",
  "325",
  "328",
  "474",
  "329",
];

class CategoryView extends StatefulWidget {
  CategoryView({Key key});

  @override
  _CategoryViewState createState() => new _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(vsync: this, length: _allPages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Container(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "基础分类",
              style: TextStyle(
                color: Colors_Wd.TEXT_GREY1,
                fontSize: 30.0,
              ),
            ),
          ),
          backgroundColor: Colors_Wd.TEXT_WHITE,
          actions: <Widget>[
            Container(
              child: Image.asset(
                "images/common/search.png",
                width: 30.0,
                height: 30.0,
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            )
          ],
          bottom: new TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: _allPages.map((data) {
              return Container(
                  height: 45.0,
                  child: Center(
                    child: Text(data,
                        style: TextStyle(
                          color: Colors_Wd.TEXT_GREY1,
                        )),
                  ));
            }).toList(),
            indicatorColor: Colors_Wd.TEXT_YELLOW,
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: _allId.map((id) {
            return CateListView(id: id);
          }).toList(),
        ));
  }
}
