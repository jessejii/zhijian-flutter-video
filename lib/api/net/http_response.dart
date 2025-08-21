/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'http_exceptions.dart';

class HttpResponse {
  late bool ok;
  dynamic data;
  HttpException? error;

  // HttpResponse._internal({this.ok = false});

  HttpResponse.success(this.data) : ok = true;

  HttpResponse.failure({String? errorMsg, int? errorCode}) {
    error = BadRequestException(message: errorMsg, code: errorCode);
    ok = false;
  }

  HttpResponse.failureFormResponse({dynamic data})
      : error = BadResponseException(data),
        ok = false;

  HttpResponse.failureFromError([HttpException? error])
      : error = error ?? UnknownException(),
        ok = false;

  @override
  String toString() {
    return 'HttpResponse{ok: $ok, data: $data, error: $error}';
  }
}
