/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:dio/dio.dart';

import '../../utils/application.dart';
import '../../utils/config.dart';

///Token拦截器
class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //授权码
    _token = Application.prefs.get(Config.TOKEN_KEY);
    if (_token != null) {
      options.headers["Authorization"] = 'Bearer ${_token!}';
    }

    super.onRequest(options, handler);
  }

/*
//Todo refreshtoken 自动刷新accesstoken 让at保存时间短一些,rt时间长一些,这样更加安全
//取消获取header的token自动获取和保存
@override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    var responseJson = response.data;
    if (response.statusCode == 200 &&
        responseJson["token"] != null &&
        responseJson["token"] != _token) {
      _token = 'Bearer ' + responseJson["token"];
      await Application.prefs.setString(Config.TOKEN_KEY, _token!);
    }
    super.onResponse(response, handler);
  }*/

}
