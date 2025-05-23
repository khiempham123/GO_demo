import 'package:flutter/cupertino.dart';
import 'package:weather_demo/modules/base/exception.dart';

abstract class BaseModel extends ChangeNotifier {
  ViewState? viewState;
  RException? responseError1;
  ValueNotifier? notifier;

  ProgressState progressState = ProgressState.initial;

  ViewState get initState => ViewState.initial;

  BaseModel() {
    viewState = initState;
  }

  void setState(ViewState newState, {bool forceUpdate = false, dynamic error}) {
    if (viewState == newState && !forceUpdate) return;

    viewState = newState;
    if (viewState == ViewState.error && error != null) {
      responseError1 = RException.wrap(error);
    }
    notifyListeners();
  }

  Future<T?> doTask<T>({
    required Future<T?> Function() doSomething,
    bool isLoading = false,
  }) async {
    T? res;
    try {
      progressState = ProgressState.processing;
      res = await doSomething();
      progressState = ProgressState.success;
    } catch (e) {
      responseError1 = RException.wrap(e);
      progressState = ProgressState.error;
    }
    if (isLoading) {
      notifier?.notifyListeners();
    }
    return res;
  }

  void changeNotifyAnimation() {
    notifier?.notifyListeners();
  }

  Future<void> catchError(String? errorMessage) async {}

  @override
  void dispose() {
    super.dispose();
    notifier?.dispose();
  }
}

enum ViewState { initial, loading, loaded, error }

enum ProgressState { initial, processing, success, error }
