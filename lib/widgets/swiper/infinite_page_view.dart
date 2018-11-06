import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Timer;

class InfinitePageView extends StatefulWidget {
  InfinitePageView({
    Key key,
    this.imageWidgets,
    this.onPageChanged,
    this.isAutoPlay,
    this.autoPlay,
    this.timer,
    this.pageController,
    this.isLoop,
  });

  final List<Widget> imageWidgets;
  final ValueChanged<int> onPageChanged;
  final bool isAutoPlay;
  final int autoPlay;
  final Timer timer;
  final PageController pageController;
  final bool isLoop;

  @override
  _InfinitePageViewState createState() => new _InfinitePageViewState();
}

class _InfinitePageViewState extends State<InfinitePageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return SizedBox.expand(
            child: widget.imageWidgets.length == 0
                ? Container()
                : widget.imageWidgets[index % widget.imageWidgets.length]);
      },
      controller: widget.pageController,
      onPageChanged: widget.onPageChanged,
      itemCount: widget.isLoop ? null : widget.imageWidgets.length,

    );
  }
}
