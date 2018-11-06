import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentProvider extends InheritedWidget {
  ContentProvider({Key key, this.rootContent, Widget child})
      : super(key: key, child: child);

  final BuildContext rootContent;

  static ContentProvider of(BuildContext context) {
    //为了首页ios风格tab跳转到新的页面，只存在一个navigator栈，而不是每一个tab都有一个navigator栈
    return context.inheritFromWidgetOfExactType(ContentProvider);
  }

  @override
  bool updateShouldNotify(ContentProvider old) {
    return rootContent != old.rootContent;
  }
}
