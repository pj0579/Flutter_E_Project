import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/network.dart';
import 'package:cook_mother/utils/api.dart';
import 'package:cook_mother/common/row_item.dart';
import 'package:cook_mother/tabViews/content_provider.dart';
import 'package:cook_mother/pages/product_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_mother/utils/colors.dart';

class CateListView extends StatefulWidget {
  CateListView({Key key, this.id, this.index});

  final String id;
  final int index;

  @override
  _CateListViewState createState() => new _CateListViewState();
}

class _CateListViewState extends State<CateListView>
    with AutomaticKeepAliveClientMixin {
  BuildContext c;
  List products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ajaxList();
    print("111");
  }

  ajaxList() {
    getHttp(host: Api.HOST, path: Api.CATE_LIST + widget.id + ".jhtml", query: {
      "pageNumber": "1",
      "pageSize": "10",
      "orderType": "dateDesc",
      "storageRackId": "2",
      'timestamp': new DateTime.now().millisecondsSinceEpoch.toString(),
    }).then((res) {
      setState(() {
        products = res['products'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    c = ContentProvider.of(context).rootContent;
    return Column(
      children: <Widget>[
        Container(
          color: Colors_Wd.TEXT_WHITE,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'images/common/category/jgn.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                    margin: new EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
                  ),
                  Text("新品排序"),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'images/common/category/jgn.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                    margin: new EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
                  ),
                  Text("新品排序"),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'images/common/category/jgn.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                    margin: new EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
                  ),
                  Text("新品排序"),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                flexibleSpace: Container(
                  child: CachedNetworkImage(
                      imageUrl: "http://img.weidao.com/catlist/" + widget.id + ".png"),
                ),
                expandedHeight: 100.0,
                backgroundColor: Colors_Wd.TEXT_WHITE,
              ),
              new SliverGrid(
                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (MediaQuery.of(context).size.width) / 2,
                  childAspectRatio: 0.62,
                ),
                delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Center(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            c,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProductDetail(data: products[index])));
                      },
                      child: RowItem(
                        data: products[index],
                      ),
                    ));
                  },
                  childCount: products.length,
                ),
              )
            ],
          ),
          padding: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
