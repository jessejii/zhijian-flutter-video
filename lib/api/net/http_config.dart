/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:dio/dio.dart';

/// dio 配置项
class HttpConfig {
  final String? baseUrl;
  final String? proxy;
  final bool ignoreCertificate;
  final String? cookiesPath;
  final List<Interceptor>? interceptors;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;
  final String? contentType;
  final Map<String, dynamic>? headers;

  HttpConfig({
    this.baseUrl,
    this.proxy,
    this.ignoreCertificate = false,
    this.cookiesPath,
    this.interceptors,
    this.headers,
    this.contentType,
    this.connectTimeout = Duration.millisecondsPerMinute,
    this.sendTimeout = Duration.millisecondsPerMinute,
    this.receiveTimeout = Duration.millisecondsPerMinute,
  });

// static DioConfig of() => Get.find<DioConfig>();
}
