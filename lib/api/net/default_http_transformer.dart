/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:dio/dio.dart';

import '../../api/net/http_response.dart';
import 'http_transformer.dart';

class DefaultHttpTransformer extends HttpTransformer {
// 假设接口返回类型
//   {
//     "code": 100,
//     "data": {},
//     "message": "success"
// }
  @override
  HttpResponse parse(Response response) {
    try {
      if (response.data["code"] == 200) {
        return HttpResponse.success(response.data["data"]);
      } else {
        return HttpResponse.failure(
            errorMsg: '接口错误:${response.data["message"] ?? response.data["msg"]}',
            errorCode: response.data["code"]);
      }
    } catch (e) {
      return HttpResponse.failure(errorMsg: "系统获取格式错误", errorCode: 333);
    }
  }

  /// 单例对象
  static final DefaultHttpTransformer _instance =
      DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}
