import 'package:cook_mother/modal/stack_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'package:cook_mother/utils/network.dart';
import 'package:cook_mother/utils/api.dart';
import 'dart:async';

class CartView extends StatefulWidget {
  CartView({Key key});

  @override
  _CartViewState createState() => new _CartViewState();
}

class _CartViewState extends State<CartView> {
  var testList = [0, 1, 2, 3, 4, 5];
  var imgUrl=["images/test0.jpg","images/test1.jpg","images/test2.jpg","images/test3.jpg","images/test4.jpg","images/test5.jpg"];
  var list=[0, 1, 2, 3, 4, 5];
  var length = 6;
  var img;
  var animation;
  var animation1;
  var time = 3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animation = testList.map((index) {
      return StackAnimation(
        start: index < length - 4
            ? 80.0
            : (index == length - 1 ? 600.0 : 20.0 + index * 20.0),
        top: index < length - 4 ? 80.0 : 110.0 - index * 10,
        width: index < length - 4 ? 80.0 : (20.0 + index * 20.0),
        height: index < length - 4 ? 80.0 : (20.0 + index * 20.0),
        opcity:  index==3?1.0:(index==2?1.0:index==4?1.0:0.0),
      );
    }).toList();
    animation1 = testList.map((index) {
      return StackAnimation(
        start: index < length - 4
            ? 80.0
            : (index == length - 1 ? 600.0 : 20.0 + index * 20.0),
        top: index < length - 4 ? 80.0 : 110.0 - index * 10,
        width: index < length - 4 ? 80.0 : (20.0 + index * 20.0),
        height: index < length - 4 ? 80.0 : (20.0 + index * 20.0),
        opcity:  index==3?1.0:(index==2?1.0:index==4?1.0:0.0),
      );
    }).toList();
  }

  ajaxCartList() {
    getHttp(host: Api.HOST, path: Api.CART_LIST, query: {
      "token": "",
      "cartId": "1",
    });
  }

  right() {

   setState(() {
     animation[2].opcity = animation1[1].opcity;
     animation[3].width = animation1[2].height;
     animation[3].height = animation1[2].width;
     animation[3].start = animation1[2].start;
     animation[4].width = animation1[3].height;
     animation[4].height = animation1[3].width;
     animation[4].start = animation1[3].start;
     animation[5].width = animation1[4].height;
     animation[5].height = animation1[4].width;
     animation[5].start = animation1[4].start;
   });
   Future.delayed(Duration(seconds: 3),(){
     setState(() {
       time=0;
       animation[2].opcity = animation1[2].opcity;
       animation[3].width = animation1[3].height;
       animation[3].height = animation1[3].width;
       animation[3].start = animation1[3].start;
       animation[4].width = animation1[4].height;
       animation[4].height = animation1[4].width;
       animation[4].start = animation1[4].start;
       animation[5].width = animation1[5].height;
       animation[5].height = animation1[5].width;
       animation[5].start = animation1[5].start;
     });
     setState(() {
       var last = testList.removeLast();
       testList.insert(0, last);
     });
   });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlatButton(onPressed: right, child: Text("开始动画")),
        backgroundColor: Colors_Wd.BACKGROUND_RED3_COLOR,
      ),
      body: new Directionality(
        textDirection: TextDirection.rtl,
        child: new Stack(
          children: testList.map((index) {
            return AnimatedPositionedDirectional(
            child: Opacity(
                opacity: animation[index].opcity,
                child: Image.asset(imgUrl[testList[index]]),
              ),
              start: animation[index].start,
              top: animation[index].top,
              width: animation[index].width,
              height: animation[index].height,
              duration: Duration(seconds: time),
            );
          }).toList(),
        ),
      ),
    );
  }
}
