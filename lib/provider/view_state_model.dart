/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../api/net/http_exceptions.dart';
import 'view_state.dart';

export 'view_state.dart';

class ViewStateModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  /// 根据状态构造
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({ViewState? viewState})
      : _viewState = viewState ?? ViewState.idle;

  /// ViewState
  ViewState get viewState => _viewState;

  /// ViewStateError
  ViewStateError? _viewStateError;

  ViewStateError? get viewStateError => _viewStateError;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  bool get isBusy => _viewState == ViewState.busy;

  bool get isIdle => _viewState == ViewState.idle;

  bool get isEmpty => _viewState == ViewState.empty;

  bool get isError => _viewState == ViewState.error;

  /// set
  void setIdle() {
    _viewState = ViewState.idle;
    _viewStateError = null;
    notifyListeners();
  }

  void setBusy() {
    _viewState = ViewState.busy;
    _viewStateError = null;
    notifyListeners();
  }

  void setEmpty() {
    _viewState = ViewState.empty;
    _viewStateError = null;
    notifyListeners();
  }

  /// [e]分类Error和Exception两种
  void setError([Exception? error]) {
    ViewStateErrorType errorType;
    if (error is HttpException) {
      switch (error.code) {
        case 201:
          errorType = ViewStateErrorType.unauthorizedError;
          break;
        case 400:
        case 401:
        case 403:
        case 404:
        case 405:
        case 502:
        case 505:
        case -1:
          errorType = ViewStateErrorType.networkTimeOutError;
          break;
        case 500:
        case 503:
        default:
          errorType = ViewStateErrorType.defaultError;
      }
      _viewStateError = ViewStateError(
        errorType,
        message: error.message,
      );
    } else {
      errorType = ViewStateErrorType.defaultError;
      _viewStateError = ViewStateError(
        errorType,
        message: "$error",
      );
    }

    _viewStateError = error == null ? null : _viewStateError;
    onError(_viewStateError);
    //只要调用setError肯定就是出错了
    // _viewState = error == null ? ViewState.idle : ViewState.error;
    _viewState = ViewState.error;
    notifyListeners();
  }

  void onError(ViewStateError? viewStateError) {
    if (viewStateError != null) {
      BotToast.showText(
        text: viewStateError.message ?? "系统出错",
        align: Alignment.topCenter,
        duration: const Duration(seconds: 2),
        textStyle: const TextStyle(fontSize: 14, color: Colors.white),
      );
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  String toString() {
    return 'ViewStateModel{_disposed: $_disposed, _viewState: $_viewState, _viewStateError: $_viewStateError}';
  }
}
