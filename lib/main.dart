import 'package:flutter/material.dart';
import 'package:cook_mother/pages/home_page.dart' show MyHomePage;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cook_mother/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:cook_mother/redux/app_state.dart';

void main() => runApp(RootApp());

class RootApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
        store: this.store,
        child: MaterialApp(
          home: MyHomePage(),
        ),
      );
}
