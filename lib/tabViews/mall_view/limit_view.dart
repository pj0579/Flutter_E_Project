import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cook_mother/custom/swiper/swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_mother/custom/count_down/timer.dart';

class LimitView extends StatefulWidget {
  LimitView({Key key, this.limitData});

  final List limitData;

  @override
  _LimitViewState createState() => new _LimitViewState();
}

class _LimitViewState extends State<LimitView> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.limitData.length == 0
        ? Container(
            height: 0.0,
          )
        : Column(children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '限时抢购',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors_Wd.TEXT_GREY1,
                          ),
                        ),
                        Text(
                          '早中晚三次秒杀，限时开抢中',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors_Wd.TEXT_GREY2,
                          ),
                        )
                      ],
                    ),
                    Timers(
                        start:
                            new DateTime.now().millisecondsSinceEpoch ~/ 1000,
                        end: widget.limitData[0]['start'] ~/ 1000),
                  ],
                )),
            Container(
              height: MediaQuery.of(context).size.width / 2 + 50,
              child: Swiper(
                  fraction: 0.5,
                  isLoop: true,
                  isAutoPlay: false,
                  imageWidgets: widget.limitData.map((data) {
                    return Card(
                      margin: new EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: MediaQuery.of(context).size.width / 2,
                              child: SizedBox.expand(
                                child: CachedNetworkImage(
                                  imageUrl: data["listImage"],
                                  fit: BoxFit.fill,
                                  placeholder:
                                      new Image.asset("images/common/log.png"),
                                  fadeOutDuration:
                                      const Duration(milliseconds: 0),
                                  fadeOutCurve: Curves.easeOut,
                                  fadeInDuration:
                                      const Duration(milliseconds: 0),
                                  fadeInCurve: Curves.easeIn,
                                ),
                              )),
                          Text(
                            "  " + data["title"],
                            maxLines: 1,
                          ),
                          Text(
                            '  ￥' + '9.9',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors_Wd.TEXT_RED1,
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList()),
            )
          ]);
  }
}
