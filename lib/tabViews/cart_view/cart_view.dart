import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cook_mother/utils/network.dart';
import 'package:cook_mother/utils/api.dart';

class CartView extends StatefulWidget {
  CartView({Key key});

  @override
  _CartViewState createState() => new _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  ajaxCartList() {
    getHttp(host: Api.HOST, path: Api.CART_LIST, query: {
      "token": "",
      "cartId": "1",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        backgroundColor: Colors_Wd.BACKGROUND_RED3_COLOR,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[],
            ),
          ),
          Container(
            color: Colors_Wd.TEXT_RED1,
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
