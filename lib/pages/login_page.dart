import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cook_mother/utils/network.dart';
import 'package:cook_mother/utils/api.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key});

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller;

  goBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  buildAppBar() => AppBar(
        leading: GestureDetector(
            onTap: goBack,
            child: Center(
                child: Container(
              padding: new EdgeInsets.all(10.0),
              child: Image.asset(
                "images/common/back.png",
                width: 20.0,
                height: 20.0,
              ),
            ))),
        title: Text('登录'),
        backgroundColor: Colors_Wd.BACKGROUND_RED3_COLOR,
      );

  login() {
    postHttp(host: Api.HOST, path: Api.LOGIN_KEY, query: {}).then((res) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.all(5.0),
            margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '用户手机号',
              ),
              keyboardType: TextInputType.phone,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          Container(
            padding: new EdgeInsets.all(5.0),
            margin: new EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '用户密码',
              ),
              keyboardType: TextInputType.phone,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          Center(
            child: CupertinoButton(
              child: Container(
                alignment: Alignment.center,
                height: 45.0,
                width: 150.0,
                child: Text(
                  '登录',
                  style: TextStyle(color: Colors_Wd.TEXT_WHITE),
                ),
                decoration: BoxDecoration(
                    color: Colors_Wd.BACKGROUND_RED3_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
              onPressed: login,
            ),
          )
        ],
      ),
    );
  }
}
