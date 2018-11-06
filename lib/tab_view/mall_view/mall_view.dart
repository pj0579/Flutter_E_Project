import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/widgets/swiper/swiper.dart';
import 'package:cook_mother/utils/network.dart';
import 'package:cook_mother/utils/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'limit_view.dart';
import 'common_view.dart';
import 'dart:async';

class MallView extends StatefulWidget {
  MallView({Key key});

  @override
  _MyMallView createState() => new _MyMallView();
}

class _MyMallView extends State<MallView> {
  List images = [];
  List limitData = [];
  List homeData = [];
  bool isShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLoopPictures();
    fetchLimit();
    fetchHome();
  }

  fetchLoopPictures() async {
    getHttp(host: Api.HOST, path: Api.LOOP_PICTURE, query: {
      'timestamp': new DateTime.now().millisecondsSinceEpoch.toString()
    }).then((res) {
      this.setState(() {
        images = res["ads"];
        Timer(new Duration(seconds: 3), () {
          isShow = true;
          setState(() {});
        });
      });
    });
  }

  fetchLimit() async {
    postHttp(host: Api.HOST, path: Api.LIMIT, query: {
      'timestamp': new DateTime.now().millisecondsSinceEpoch.toString(),
      'type': '2',
      'pageSize': '5',
    }).then((res) {
      this.setState(() {
        limitData = res['products'] == null ? [] : res['products'];
      });
      print(limitData);
    });
  }

  fetchHome() async {
    postHttp(host: Api.HOST, path: Api.HOME, query: {
      'timestamp': new DateTime.now().millisecondsSinceEpoch.toString(),
    }).then((res) {
      this.setState(() {
        homeData = res['products'] == null ? [] : res['products'];
        print(homeData.length);
      });
    });
  }

  Widget _sliverBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: false,
      primary: false,
      expandedHeight: MediaQuery.of(context).size.width / 2.5,
      flexibleSpace: new SizedBox.expand(
        child: Swiper(
            fraction: 1.0,
            isLoop: false,
            isAutoPlay: false,
            imageWidgets: images.map<Widget>((data) {
              return CachedNetworkImage(
                imageUrl: data["image"],
                fit: BoxFit.fill,
                placeholder: new Image.asset("images/common/log.png"),
                fadeOutDuration: const Duration(milliseconds: 0),
                fadeOutCurve: Curves.easeOut,
                fadeInDuration: const Duration(milliseconds: 0),
                fadeInCurve: Curves.easeIn,
                height: MediaQuery.of(context).size.width / 2.5,
              );
            }).toList()),
      ),
    );
  }

  Widget _sliverList() {
    return new SliverList(
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          print(index);
          return index == 0
              ? Column(children: <Widget>[
                  LimitView(
                    limitData: limitData,
                  ),
                  CommonView(data: homeData[index])
                ])
              : CommonView(data: homeData[index]);
        },
        childCount: homeData.length != 0 ? homeData.length : 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isShow
          ? CustomScrollView(
              slivers: <Widget>[
                _sliverBar(),
                _sliverList(),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
    );
  }
}
