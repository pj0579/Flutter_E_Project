import 'dart:ui' show Color;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/widgets/swiper/infinite_page_view.dart';
import 'dart:async' show Timer;

class Swiper extends StatefulWidget {
  Swiper({
    Key key,
    @required this.imageWidgets,
    this.activeColor: Colors.amberAccent,
    this.inactiveColor: Colors.white70,
    this.isAutoPlay: false,
    this.autoPlay: 3000, //毫秒
    this.fraction: 1.0,
    this.isLoop: false,
  });

  final List<Widget> imageWidgets;
  final Color inactiveColor;
  final Color activeColor;
  final int autoPlay;
  final double fraction;
  final bool isLoop;
  bool isAutoPlay;

  @override
  _SwiperState createState() => new _SwiperState();
}

class _SwiperState extends State<Swiper> {
  PageController pageController;
  int index = 0;
  Timer timer;
  int i = 1000;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: widget.isLoop ? 1000 : 0,
        viewportFraction: widget.fraction);
    if (widget.isAutoPlay) {
      timer =
          new Timer.periodic(Duration(milliseconds: widget.autoPlay), (timer) {
        pageController.animateToPage(++i,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      });
    }
  }

  onPageChanged(i) {
    this.setState(() {
      this.i = i;
      if (widget.isLoop) {
        index = i - 1000 >= 0
            ? (i - 1000) % widget.imageWidgets.length
            : widget.imageWidgets.length -
                (1000 - i) % widget.imageWidgets.length;
      } else {
        index = i;
      }
    });
  }

  List<int> initArray() {
    List<int> array = [];
    for (int i = 0; i < widget.imageWidgets.length; i++) {
      array.add(i);
    }
    return array;
  }

  @override
  Widget build(BuildContext context) {
    return new Listener(
        onPointerDown: (e) {
          if (widget.isAutoPlay) {
            timer.cancel();
          }
        },
        onPointerUp: (e) {
          if (widget.isAutoPlay) {
            timer = new Timer.periodic(Duration(milliseconds: widget.autoPlay),
                (timer) {
              pageController.animateToPage(++i,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear);
            });
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            InfinitePageView(
              imageWidgets: widget.imageWidgets,
              onPageChanged: onPageChanged,
              isAutoPlay: widget.isAutoPlay,
              autoPlay: widget.autoPlay,
              timer: timer,
              pageController: pageController,
              isLoop: widget.isLoop,
            ),
            widget.fraction == 1.0
                ? Positioned(
                    child: Row(
                        children: initArray().map((int i) {
                      return Container(
                          width: 5.0,
                          height: 5.0,
                          margin: const EdgeInsets.all(2.0),
                          decoration: new BoxDecoration(
                            color: i == index
                                ? widget.activeColor
                                : widget.inactiveColor,
                            shape: BoxShape.circle,
                          ));
                    }).toList()),
                    bottom: 10.0,
                  )
                : Positioned(
                    child: Container(),
                  )
          ],
        ));
  }
}
