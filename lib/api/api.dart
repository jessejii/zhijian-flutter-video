/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

//项目请求接口
import 'dart:io';

import 'package:dio/dio.dart';

import '../api/net/http_config.dart';
import '../api/net/http_dio.dart';
import '../utils/application.dart';
import '../utils/config.dart';
import 'net/http_response.dart';

HttpConfig dioConfig = HttpConfig(
  baseUrl: Config.BASE_URL,
  proxy: Config.PROXY,
  receiveTimeout: Config.RECEIVE_TIMEOUT,
  connectTimeout: Config.CONNECT_TIMEOUT,
  sendTimeout: Config.SEND_TIMEOUT,
  contentType: Config.CONTENT_TYPE,
  headers: Config.HEADER,
  cookiesPath: '${Application.documentDir.path}${Platform.pathSeparator}cookie',
);
HttpDio client = HttpDio(dioConfig: dioConfig);

class Api {
  //app检查更新
  static Future<HttpResponse> appUpdate() async {
    return await client.get('app/update'); //暂不考虑失败,请求拦截器自动判断
  }

//视频列表
  static Future<HttpResponse> videoList(
      {int? cid, int? uid, int? pageNum, String? searKey}) async {
    // print('$cid--$uid--$pageNum');
    var res = await client.get('video/index', queryParameters: {
      'pid': cid,
      'user_id': uid,
      'page': pageNum,
      'keys': searKey
    });
    return res;
  }

  //文章列表
  static Future<HttpResponse> articleList(
      {int? cid, int? uid, int? pageNum}) async {
    // print('$cid---$pageNum');
    var res = await client.get('article/index',
        queryParameters: {'pid': cid, 'user_id': uid, 'page': pageNum});
    return res;
  }

  //获取会员公共信息
  static Future<HttpResponse> userPubInfo(int? uid) async {
    var user = await client.get('user/pub_info', queryParameters: {'uid': uid});
    return user;
  }

  //获取会员信息
  static Future<HttpResponse> userInfo() async {
    var user = await client.get('user/info');
    return user;
  }

  //获取手机验证码
  static Future<HttpResponse> phoneCode(String phone) async {
    return await client.post('oauth/send_login_code', data: {'mobile': phone});
  }

  //登录
  static Future<dynamic> login(String phone, String code) async {
    // print("phone:$phone code:$code");
    var user = await client
        .post('oauth/phone_login', data: {'mobile': phone, 'code': code});
    return user;
  }

  //修改昵称
  static Future<HttpResponse> changeUsername(String name) async {
    var user =
        await client.post('user/change_username', data: {'username': name});
    return user;
  }

  //修改头像
  static Future<HttpResponse> changeAvatar(String localImagePath,
      {ProgressCallback? onSendProgress}) async {
    return await client.fileUplod('user/upload_avatar', localImagePath,
        onSendProgress: onSendProgress);
  }

  //订阅列表
  static Future<HttpResponse> subList({int? pageNum}) async {
    var res = await client
        .get('userfriend/index', queryParameters: {'page': pageNum});
    return res;
  }

  //订阅反订阅
  static Future<HttpResponse> subdToggle({required int subUserId}) async {
    var res = await client
        .post('userfriend/add_toggle', data: {'sub_user_id': subUserId});
    return res;
  }

  //是否订阅
  static Future<HttpResponse> haveSub({int? subUserId}) async {
    var res = await client.get('userfriend/have_sub',
        queryParameters: {'sub_user_id': subUserId});
    return res;
  }

  //收藏添加和删除
  static Future<HttpResponse> favAddToggle(
      {required String infoControl, required int infoId}) async {
    var res = await client.post('userfav/add_toggle',
        data: {'info_control': infoControl, 'info_id': infoId});
    return res;
  }

  //获取全部收藏
  static Future<HttpResponse> favAll() async {
    var res = await client.get('userfav/all');
    return res;
  }

  //收藏列表
  static Future<HttpResponse> favList({int? pageNum}) async {
    var res =
        await client.get('userfav/index', queryParameters: {'page': pageNum});
    return res;
  }

  //消息列表
  static Future<HttpResponse> messageList({int? pageNum}) async {
    var res = await client.get('user/msg', queryParameters: {'page': pageNum});
    return res;
  }

  //评论列表
  static Future<HttpResponse> commentList(
      {String? infoControl, int? infoId, int? pageNum}) async {
    var res = await client.get('comment/index', queryParameters: {
      'page': pageNum,
      'info_control': infoControl,
      'info_id': infoId,
    });
    return res;
  }

  //添加评论
  static Future<HttpResponse> commentAdd(
      {required String infoControl,
      required int infoId,
      required String content}) async {
    var res = await client.post('comment/add', data: {
      'info_control': infoControl,
      'info_id': infoId,
      'content': content
    });
    return res;
  }
}
