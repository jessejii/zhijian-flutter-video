/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

/// 页面状态类型
enum ViewState {
  idle,
  busy, //加载中
  empty, //无数据
  error, //加载失败
}

/// 错误类型
enum ViewStateErrorType {
  defaultError,
  networkTimeOutError, //网络错误
  unauthorizedError //为授权(一般为未登录)
}

class ViewStateError {
  final ViewStateErrorType _errorType;
  String? message;

  ViewStateError(this._errorType, {this.message}) {
    message = message ?? '未知错误';
  }

  ViewStateErrorType get errorType => _errorType;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  bool get isDefaultError => _errorType == ViewStateErrorType.defaultError;

  bool get isNetworkTimeOut =>
      _errorType == ViewStateErrorType.networkTimeOutError;

  bool get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $_errorType, message: $message}';
  }
}
