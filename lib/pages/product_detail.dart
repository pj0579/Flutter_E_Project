import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_mother/utils/network.dart';
import 'package:cook_mother/utils/api.dart';
import 'package:cook_mother/widgets/swiper/swiper.dart';
import 'package:cook_mother/utils/colors.dart';
import 'dart:async' show Timer;
import 'package:flutter_wechat/flutter_wechat.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.data});

  final Map data;

  @override
  _ProductDetailState createState() => new _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Map product = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      fetchDetail();
    });
  }

  ///获取商品详情
  fetchDetail() {
    postHttp(
            host: Api.HOST,
            path: Api.PRODUCT_DETAIL + widget.data['id'].toString() + '.json')
        .then((res) {
      setState(() {
        product = res['product'];
        print(product);
      });
    });
  }

  ///微信分享
  share({int type: 0}) {
    FlutterWechat.shareWebPage(
      webpageUrl: Api.HOME +
          "/mmall/" +
          product['mlink'] +
          "?shareuid=" +
          product["id"].toString() +
          "&mid=" +
          product["id"].toString(),
      title: product['name'],
      description: product['introduction'],
      imgUrl: product['mobileImage'],
      type: type,
    );
  }

  ///头部swiper
  Widget _swiperWiget() {
    return !product.containsKey('mobileImages')
        ? Hero(
            tag: widget.data["mobileImage"],
            child: new CachedNetworkImage(
              imageUrl: widget.data["mobileImage"],
              fit: BoxFit.cover,
              placeholder: new Image.asset("images/common/log.png"),
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
            ))
        : Container(
            height: MediaQuery.of(context).size.width,
            child: Swiper(
                fraction: 1.0,
                isLoop: false,
                isAutoPlay: false,
                imageWidgets: product['mobileImages'].map<Widget>((data) {
                  return CachedNetworkImage(
                    imageUrl: data,
                    fit: BoxFit.fill,
                    placeholder: new Image.asset("images/common/log.png"),
                    fadeOutDuration: const Duration(milliseconds: 0),
                    fadeOutCurve: Curves.easeOut,
                    fadeInDuration: const Duration(milliseconds: 0),
                    fadeInCurve: Curves.easeIn,
                    height: MediaQuery.of(context).size.width / 2.5,
                  );
                }).toList()));
  }

  ///商品名等信息
  Widget _infoWiget() {
    return Container(
      padding: new EdgeInsets.fromLTRB(16.0, 10.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 150,
              height: 100.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.data["name"],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    product["secondName"] ?? "",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors_Wd.TEXT_GREY2,
                    ),
                    maxLines: 1,
                  ),
                ],
              )),
          Container(
            width: 80.0,
            height: 70.0,
            child: Center(
              child: new Image.asset(
                'images/common/kf.png',
                width: 41.0,
                height: 52.0,
              ),
            ),
            decoration: new BoxDecoration(
                border: new Border(
                    left: new BorderSide(
                        color: Colors_Wd.BACKGROUND_GREY2_COLOR))),
          ),
        ],
      ),
    );
  }

  ///介绍
  Widget _introWidget() {
    return Container(
      padding: new EdgeInsets.fromLTRB(16.0, 0.0, 20.0, 0.0),
      child: Center(
        child: Text(
          product["introduction"] ?? "",
          style: TextStyle(
            fontSize: 12.0,
            color: Colors_Wd.TEXT_GREY2,
          ),
        ),
      ),
    );
  }

  ///商品时限
  Widget _ruleWidget() {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      margin: new EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 5.0),
      padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "￥",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors_Wd.TEXT_RED1,
                  )),
              TextSpan(
                  text: widget.data['price'].toString(),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors_Wd.TEXT_RED1,
                  ))
            ]),
          ),
          Text(
            '不支持7天无理由退货',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors_Wd.TEXT_YELLOW,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors_Wd.BACKGROUND_GREY2_COLOR, width: 0.5))),
    );
  }

  ///产品规格
  Widget _specWidget() {
    return product.containsKey("parameters") &&
            product['parameters'].length != 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: new EdgeInsets.fromLTRB(16.0, 15.0, 0.0, 5.0),
                child: Text(
                  '产品规格',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors_Wd.TEXT_GREY1,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  ///规格详细参数
  Widget _specInfoWidget() {
    return product.containsKey("parameters")
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product["parameters"].map<Widget>((data) {
              return Row(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: new EdgeInsets.fromLTRB(16.0, 5.0, 0.0, 5.0),
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors_Wd.TEXT_GREY4_COLOR,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                                text: data['name'] + "：",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: data['value']),
                          ]))),
                ],
              );
            }).toList())
        : Container();
  }

  ///价格
  Widget _priceWidget() {
    return Container(
      padding: new EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
      width: MediaQuery.of(context).size.width,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '味道价:',
            style: TextStyle(
              color: Colors_Wd.TEXT_GREY1,
              fontSize: 14.0,
            )),
        TextSpan(
            text: ' 是商品在做饭妈妈商城上的销售标价，具体的成交价格可能因会员使用优惠券、积分等发生变化，最终以订单结算价格为准。',
            style: TextStyle(
              color: Colors_Wd.TEXT_GREY2,
              fontSize: 14.0,
            ))
      ])),
    );
  }

  ///详情图
  Widget _imgs() {
    return product.containsKey('productDetailImageBeans')
        ? Column(
            children: product['productDetailImageBeans'].map<Widget>((data) {
            return new CachedNetworkImage(
              imageUrl: data['image'],
              fit: BoxFit.cover,
              placeholder: new Image.asset("images/common/log.png"),
              width: MediaQuery.of(context).size.width,
            );
          }).toList())
        : Container();
  }

  ///微信分享
  Widget _wxShareWidget() {
    return Positioned(
      top: 25.0,
      left: 25.0,
      right: 25.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Image.asset(
                'images/common/back.png',
                height: 35.0,
                width: 35.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return new Container(
                        height: 150.0,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                child: Image.asset(
                                  'images/common/wx.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                onTap: () {
                                  share(type: 0);
                                },
                              ),
                              GestureDetector(
                                  onTap: () {
                                    share(type: 1);
                                  },
                                  child: Container(
                                    margin: new EdgeInsets.fromLTRB(
                                        30.0, 0.0, 30.0, 0.0),
                                    child: Image.asset(
                                      'images/common/wx-friends.png',
                                      width: 50.0,
                                      height: 50.0,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: new Image.asset(
                'images/common/share.png',
                height: 35.0,
                width: 35.0,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      ListView(
        padding: new EdgeInsets.all(0.0),
        children: <Widget>[
          _swiperWiget(),
          _infoWiget(),
          _introWidget(),
          _ruleWidget(),
          _specWidget(),
          _specInfoWidget(),
          _priceWidget(),
          Container(
            height: 10.0,
            width: MediaQuery.of(context).size.width,
            color: Colors_Wd.BACKGROUND_GREY9_COLOR,
          ),
          _imgs(),
        ],
      ),
      _wxShareWidget()
    ]));
  }
}
