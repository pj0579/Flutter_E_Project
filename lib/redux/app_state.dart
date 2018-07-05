
class AppState {
  final int cartNumber;
  final bool isLogin;

  AppState(this.cartNumber, this.isLogin);

  factory AppState.initial() => AppState(0, false);
}
