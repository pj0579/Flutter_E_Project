import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/tab_view/mall_view/mall_view.dart';
import 'package:cook_mother/tab_view/cart_view/cart_view.dart';
import 'package:cook_mother/tab_view/category_view/category_view.dart';
import 'package:cook_mother/tab_view/content_provider.dart';
import 'package:flutter_wechat/flutter_wechat.dart';
import 'package:cook_mother/tab_view/mine_view/mine_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cook_mother/redux/app_state.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key});

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterWechat.registerWechat("wxb25d3dec3db1affc");
  }

  saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('toen') ?? null;
    if (token != null) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _buildTabBar() => CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Colors.red,
        onTap: (i) {
          this.setState(() {
            index = i;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              index == 0 ? "images/tabIcon/1.png" : "images/tabIcon/1_.png",
              width: 30.00,
              height: 30.00,
            ),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              index == 1 ? "images/tabIcon/2.png" : "images/tabIcon/2_.png",
              width: 30.00,
              height: 30.00,
            ),
            title: Text('分类'),
          ),
          BottomNavigationBarItem(
            icon: new Stack(
              children: <Widget>[
                Image.asset(
                  index == 2 ? "images/tabIcon/3.png" : "images/tabIcon/3_.png",
                  width: 30.00,
                  height: 30.00,
                ),
                new Positioned(
                  // draw a red marble
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: new EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors_Wd.BACKGROUND_RED3_COLOR,
                    ),
                    child: StoreConnector<AppState, String>(
                      converter: (store) => store.state.cartNumber.toString(),
                      builder: (context, count) {
                        return new Text(
                          count,
                          style: TextStyle(color: Colors_Wd.TEXT_WHITE),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            title: Text('购物车'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              index == 3 ? "images/tabIcon/4.png" : "images/tabIcon/4_.png",
              width: 30.00,
              height: 30.00,
            ),
            title: Text('我的'),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ContentProvider(
      rootContent: context,
      child: CupertinoTabScaffold(
          tabBar: _buildTabBar(),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                switch (index) {
                  case 0:
                    return MallView();
                    break;
                  case 1:
                    return CategoryView();
                    break;
                  case 2:
                    return CartView();
                    break;
                  case 3:
                    return MineView();
                    break;
                  default:
                }
              },
            );
          }),
    );
  }
}
