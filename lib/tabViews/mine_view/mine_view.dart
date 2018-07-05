import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cook_mother/tabViews/content_provider.dart';
import 'package:cook_mother/pages/login_page.dart';

class MineView extends StatefulWidget {
  MineView({Key key});

  @override
  _MineViewState createState() => new _MineViewState();
}

class _MineViewState extends State<MineView> {
  BuildContext c;

  goToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    c = ContentProvider.of(context).rootContent;
    return Scaffold(
      body: ListView(
        padding: new EdgeInsets.all(0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.width * 3 / 3.75,
            color: Colors_Wd.BACKGROUND_RED3_COLOR,
            padding: new EdgeInsets.fromLTRB(24.0, 45.0, 24.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    '登录/注册',
                    style: TextStyle(
                      color: Colors_Wd.TEXT_WHITE,
                      fontSize: 30.0,
                    ),
                  ),
                  onTap: () {
                    goToLoginPage(c);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    goToLoginPage(c);
                  },
                  child: Image.asset(
                    "images/common/mine/default-head.png",
                    height: 60.0,
                    width: 60.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
