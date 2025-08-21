/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zhijian/utils/config.dart';

class Helper {
  //判断是否为空
  static bool emptyValue(dynamic str) {
    // return str?.isEmpty ?? true;
    if (str == null) {
      return true;
    }
    if (str is String) {
      return str.trim().isEmpty;
    }
    if (str is bool) {
      return str;
    }
    if (str is num) {
      return str == 0 ? false : true;
    }
    if (str is List || str is Map || str is Set) {
      return str.isEmpty;
    }
    return false;
  }

  static void showToast(String title, String subTitle) {
    BotToast.showNotification(
      leading: (cancel) => SizedBox.fromSize(
          size: const Size(40, 40),
          child: IconButton(
            icon: Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: cancel,
          )),
      title: (_) => Text(title),
      subtitle: (_) => Text(subTitle),
      enableSlideOff: true,
      crossPage: true,
      contentPadding: EdgeInsets.all(11),
      onlyOne: false,
      animationDuration: Duration(milliseconds: 200),
      animationReverseDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: 2),
    );
  }

  //获取随机4位+时间戳
  static String getUUid() {
    String randomstr = Random().nextInt(10).toString();
    for (var i = 0; i < 3; i++) {
      var str = Random().nextInt(10);
      randomstr = "$randomstr$str";
    }
    var timenumber = DateTime.now().millisecondsSinceEpoch; //时间
    return "$randomstr$timenumber";
  }

  static String nowTime() {
    var now = DateTime.now();
    return '${now.month.toString().padLeft(2, '0')}-${now.day} ${now.hour}:${now.minute}';
  }

  static Future<void> openStore() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=${Config.ANDROID_APPID}"
            : "https://apps.apple.com/app/id${Config.IOS_APPID}",
      );
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
