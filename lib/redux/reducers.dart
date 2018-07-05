import 'package:redux/redux.dart';
import 'app_state.dart';
import 'actions.dart';

AppState appReducer(AppState state, action) => AppState(cartReducer(state.cartNumber, action),false);

final Reducer<int> cartReducer = combineReducers([
  TypedReducer<int, AddCartAction>(_addCart),
  TypedReducer<int, RemoveCartAction>(_removeCart),
]);

int _addCart(int cartNumber, AddCartAction action) => ++cartNumber;

int _removeCart(int cartNumber, RemoveCartAction action) => --cartNumber;
