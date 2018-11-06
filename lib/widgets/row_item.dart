import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cook_mother/redux/app_state.dart';
import 'package:cook_mother/redux/actions.dart';

class RowItem extends StatefulWidget {
  RowItem({Key key, this.data});

  final Map data;

  @override
  _RowItemState createState() => new _RowItemState();
}

class _RowItemState extends State<RowItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.data['mobileImage'],
            fit: BoxFit.fill,
            placeholder: new Image.asset("images/common/log.png"),
            fadeOutDuration: const Duration(milliseconds: 0),
            fadeOutCurve: Curves.easeOut,
            fadeInDuration: const Duration(milliseconds: 0),
            fadeInCurve: Curves.easeIn,
            height: (MediaQuery
                .of(context)
                .size
                .width - 48) / 2,
            width: (MediaQuery
                .of(context)
                .size
                .width - 48) / 2,
          ),
          Container(
            padding: new EdgeInsets.all(3.0),
            child: Text(
              widget.data['fullName'],
              maxLines: 1,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            width: (MediaQuery
                .of(context)
                .size
                .width - 48) / 2,
          ),
          Container(
            padding: new EdgeInsets.all(3.0),
            child: Text(
              widget.data['secondName'] == null
                  ? ""
                  : widget.data['secondName'],
              maxLines: 1,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors_Wd.TEXT_GREY2,
              ),
            ),
            width: (MediaQuery
                .of(context)
                .size
                .width - 48) / 2,
          ),
          Container(
            padding: new EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            width: (MediaQuery
                .of(context)
                .size
                .width - 48) / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.data['price'].toString(),
                  style: TextStyle(
                    color: Colors_Wd.TEXT_RED1,
                  ),
                ),
                StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () {
                      return store.dispatch(store.state.cartNumber%2==0?AddCartAction(store.state.cartNumber):RemoveCartAction(store.state.cartNumber));
                    };
                  },
                  builder: (context, callback) {
                    return CupertinoButton(
                      onPressed: callback,
                      padding: new EdgeInsets.all(0.0),
                      child: new Image.asset(
                        'images/common/cart.png',
                        height: 35.0,
                        width: 35.0,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
