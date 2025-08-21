/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'dart:io';

// import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../../api/net/token_interceptor.dart';
import '../../utils/config.dart';
import 'http_config.dart';
import 'http_parse.dart';
import 'http_response.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'http_transformer.dart';

class HttpDio {
  final Dio _dio = Dio();
  late HttpClientAdapter httpClientAdapter;

  static HttpDio? _instance;

  factory HttpDio({required HttpConfig dioConfig}) {
    _instance ??= HttpDio._(dioConfig);
    return _instance!;
  }

  HttpDio._(HttpConfig dioConfig) {
    _dio.options = BaseOptions(
      baseUrl: dioConfig.baseUrl ?? "",
      contentType: dioConfig.contentType,
      connectTimeout: Duration(milliseconds: dioConfig.connectTimeout),
      sendTimeout: Duration(milliseconds: dioConfig.sendTimeout),
      receiveTimeout: Duration(milliseconds: dioConfig.receiveTimeout),
      headers: dioConfig.headers,
    );
    /*    // DioCacheManager
    final cacheOptions = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(days: 7),
    );
    _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));*/
    // Cookie管理
    /*if (dioConfig.cookiesPath?.isNotEmpty ?? false) {
      _dio.interceptors.add(CookieManager(
          PersistCookieJar(storage: FileStorage(dioConfig!.cookiesPath))));
    }*/
    // token拦截
    _dio.interceptors.add(TokenInterceptors());

    if (Config.DEBUG) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
    if (dioConfig.interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(dioConfig.interceptors!);
    }
    _initAdapter(dioConfig);
  }

  void _initAdapter(HttpConfig dioConfig) {
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        //代理
        if (dioConfig.proxy?.isEmpty ?? false) {
          client.findProxy = (uri) {
            return "PROXY ${dioConfig.proxy}";
          };
        }
        if (Config.DEBUG) {
          //忽略证书
          client.badCertificateCallback = (cert, host, port) {
            return true;
          };
        }

        return client;
      },
    );
  }

  Future<HttpResponse> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> patch(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> delete(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> put(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  //下载
  Future<Response> download(String urlPath, savePath,
      {ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: data,
      );
      return response;
    } catch (e) {
      // throw e;
      rethrow;
    }
  }

  // 上传文件（图片）
  Future<HttpResponse> fileUplod(String urlPath, String localImagePath,
      {ProgressCallback? onSendProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options,
      HttpTransformer? httpTransformer}) async {
    String suffix = localImagePath.substring(
        localImagePath.lastIndexOf(".") + 1, localImagePath.length);
    Map<String, dynamic> map = {};
    map["file"] = await MultipartFile.fromFile(localImagePath);
    map["contentType"] = ContentType.parse("image/$suffix");
    //通过FormData
    FormData formData = FormData.fromMap(map);

    var option =
        options ?? Options(method: "POST", contentType: "multipart/form-data");
    try {
      //发送post
      var response = await _dio.post(
        urlPath,
        data: formData,
        options: option,
        onSendProgress: onSendProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }
}
