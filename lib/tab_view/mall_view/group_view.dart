import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_mother/tab_view/content_provider.dart';
import 'package:cook_mother/pages/product_detail.dart';
import 'package:cook_mother/widgets/swiper/swiper.dart';
import 'package:cook_mother/utils/network.dart';
import 'package:cook_mother/utils/api.dart';

class GroupView extends StatefulWidget {
  GroupView({Key key});

  @override
  _GroupViewState createState() => new _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  List images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGroup();
  }

  ///  获取团购信息

  fetchGroup() async {
    getHttp(host: Api.HOST, path: Api.GROUP, query: {
      'timestamp': new DateTime.now().millisecondsSinceEpoch.toString()
    }).then((res) {
      images = res['products'] != null ? res['products'] : [];
    });
  }

  ///header头部
  Widget _header() {
    return Container(
        margin: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '一起拼团',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors_Wd.TEXT_GREY1,
                  ),
                ),
                Text(
                  '实惠价格，品尝最鲜美味',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors_Wd.TEXT_GREY2,
                  ),
                )
              ],
            ),
            Text(
              '查看全部',
              style: TextStyle(color: Colors_Wd.TEXT_YELLOW),
            )
          ],
        ));
  }

  ///尾部
  Widget _footer(data) {
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Image.asset(
                  'images/common/group.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Text(
                  " " + data['total'].toString() + '人团',
                  style: TextStyle(
                    color: Colors_Wd.TEXT_GREY2,
                  ),
                )
              ],
            ),
            Container(
              height: 38.0,
              padding: new EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: Row(
                children: <Widget>[
                  Text('￥' + data['price'].toString(),
                      style: TextStyle(color: Colors_Wd.TEXT_WHITE)),
                  Container(
                    color: Colors_Wd.TEXT_WHITE,
                    width: 1.0,
                    height: 20.0,
                    margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  ),
                  Text('去开团', style: TextStyle(color: Colors_Wd.TEXT_WHITE)),
                ],
              ),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: const Alignment(0.0, 0.0),
                  end: const Alignment(1.0, 0.0),
                  colors: <Color>[
                    const Color(0xffFF3C18),
                    const Color(0xffFF6F35)
                  ],
                ),
                borderRadius: new BorderRadius.all(
                  const Radius.circular(5.0),
                ),
              ),
            )
          ],
        ));
  }

  ///中部
  Widget _image(data) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
      child: SizedBox.expand(
        child: Hero(
            tag: data["mobileImage"],
            child: CachedNetworkImage(
              imageUrl: data["mobileImage"],
              fit: BoxFit.cover,
              placeholder: new Image.asset("images/common/log.png"),
            )),
      ),
    );
  }

  _onTap(data) {
    BuildContext c = ContentProvider.of(context).rootContent;
    Navigator.push(
      c,
      new MaterialPageRoute(
          builder: (context) => new ProductDetail(data: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return images.length != 0
        ? Column(children: <Widget>[
            _header(),
            Container(
              height: 280.0,
              child: Swiper(
                  fraction: 0.95,
                  isLoop: false,
                  imageWidgets: images.map((data) {
                    return GestureDetector(
                      onTap: () => _onTap(data),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _image(data),
                            Text(
                              "  " + data['name'],
                              maxLines: 1,
                            ),
                            Text(
                              "  " + data['secondName'],
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors_Wd.TEXT_GREY2,
                              ),
                              maxLines: 1,
                            ),
                            _footer(data)
                          ],
                        ),
                      ),
                    );
                  }).toList()),
            )
          ])
        : Container();
  }
}
