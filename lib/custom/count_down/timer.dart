import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_mother/utils/colors.dart';
import 'dart:async' show Timer;

class Timers extends StatefulWidget {
  Timers({Key key, this.start, this.end});

  int start;
  int end;

  @override
  _TimersState createState() => new _TimersState();
}

class _TimersState extends State<Timers> {
  int time = 0;
  int hour = 0;
  int min = 0;
  int sec = 0;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = widget.end - widget.start;
    sec = time % 60;
    min = ((time - sec) ~/ 60) % 60;
    hour = ((time - sec) ~/ 60) ~/ 60;
    timer = new Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (time == 0) {
          sec = 0;
          min = 0;
          hour = 0;
          timer.cancel();
        } else {
          time = time - 1;
          sec = time % 60;
          min = ((time - sec) ~/ 60) % 60;
          hour = ((time - sec) ~/ 60) ~/ 60;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('剩余'),
        Container(
            height: 30.0,
            width: 20.0,
            child: Center(
              child: Text('$hour',
                  style: TextStyle(
                      color: Colors_Wd.TEXT_RED1, fontWeight: FontWeight.bold)),
            )),
        Text('时'),
        Container(
            height: 30.0,
            width: 20.0,
            child: Center(
              child: Text('$min',
                  style: TextStyle(
                      color: Colors_Wd.TEXT_RED1, fontWeight: FontWeight.bold)),
            )),
        Text('分'),
        Container(
            height: 30.0,
            width: 20.0,
            child: Center(
              child: Text('$sec',
                  style: TextStyle(
                      color: Colors_Wd.TEXT_RED1, fontWeight: FontWeight.bold)),
            )),
        Text('秒'),
      ],
    );
  }
}
