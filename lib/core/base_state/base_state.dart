sealed class BaseState {}

class BaseInitialState extends BaseState {}

class BaseSuccessState<T> extends BaseState {
  BaseSuccessState({this.data});
  T? data;
}

class BaseLoadingState extends BaseState {}

class BaseHideLoadingState extends BaseState {}

class BaseNavigationState<T> extends BaseState {
  BaseNavigationState(this.route, [this.arguments]);
  T? arguments;
  String route;
}

class BaseErrorState extends BaseState {
  BaseErrorState({required this.errorMessage, this.exception});
  String errorMessage;
  Exception? exception;
}
