import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cook_mother/widgets/row_item.dart';
import 'package:cook_mother/tab_view/content_provider.dart';
import 'package:cook_mother/pages/product_detail.dart';

class CommonView extends StatefulWidget {
  CommonView({Key key, this.data});

  final Map data;

  @override
  _CommonViewState createState() => new _CommonViewState();
}

class _CommonViewState extends State<CommonView> {
  goToPage(Map data) {
    BuildContext c = ContentProvider.of(context).rootContent;
    Navigator.push(c,
        new MaterialPageRoute(builder: (context) => ProductDetail(data: data)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: new EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.data['categoryName'],
                style: TextStyle(
                  color: Colors_Wd.TEXT_GREY1,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '查看全部',
                style: TextStyle(
                  color: Colors_Wd.TEXT_YELLOW,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: CachedNetworkImage(
            imageUrl: widget.data['image'],
            fit: BoxFit.fill,
            placeholder: new Image.asset("images/common/log.png"),
            fadeOutDuration: const Duration(milliseconds: 0),
            fadeOutCurve: Curves.easeOut,
            fadeInDuration: const Duration(milliseconds: 0),
            fadeInCurve: Curves.easeIn,
            height: (MediaQuery.of(context).size.width - 32) / 3.2,
          ),
        ),
        Container(
          padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: (() {
                  BuildContext c = ContentProvider.of(context).rootContent;
                  Navigator.push(
                      c,
                      new MaterialPageRoute(
                          builder: (context) => ProductDetail(
                              data: widget.data['miniProductBeans'][0])));
                }),
                child: RowItem(data: widget.data['miniProductBeans'][0]),
              ),
              GestureDetector(
                onTap: (() {
                  BuildContext c = ContentProvider.of(context).rootContent;
                  Navigator.push(
                      c,
                      new MaterialPageRoute(
                          builder: (context) => ProductDetail(
                              data: widget.data['miniProductBeans'][1])));
                }),
                child: RowItem(data: widget.data['miniProductBeans'][1]),
              )
            ],
          ),
        ),
        Container(
          padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: (() {
                  BuildContext c = ContentProvider.of(context).rootContent;
                  Navigator.push(
                      c,
                      new MaterialPageRoute(
                          builder: (context) => ProductDetail(
                              data: widget.data['miniProductBeans'][2])));
                }),
                child: RowItem(data: widget.data['miniProductBeans'][2]),
              ),
              GestureDetector(
                onTap: (() {
                  BuildContext c = ContentProvider.of(context).rootContent;
                  Navigator.push(
                      c,
                      new MaterialPageRoute(
                          builder: (context) => ProductDetail(
                              data: widget.data['miniProductBeans'][3])));
                }),
                child: RowItem(data: widget.data['miniProductBeans'][3]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
