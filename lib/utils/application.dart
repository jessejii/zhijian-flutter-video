/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../generated/l10n.dart';
import '../routes/app_router.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:go_router/go_router.dart';

export '../routes/routes.dart';

class Application {
  Application._();

  static late Box prefs;
  static late Directory documentDir;
  static late Directory tempDir;
  static late PackageInfo packageInfo;
  static final botToastBuilder = BotToastInit();
  // static late FirebaseAnalytics analytics; //谷歌统计
  static late GoRouter routerConfig; //路由,需要在谷歌统计之后,因为observers中有调用
// 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //shared preferences
    await Hive.initFlutter();
    prefs = await Hive.openBox('preferences');
    //文档目录 用户不可见
    documentDir = await getApplicationDocumentsDirectory();
    //缓存目录
    tempDir = await getTemporaryDirectory();
    //初始化 下载
    await FlutterDownloader.initialize(
        debug: false // optional: set false to disable printing logs to console
        );
    //包信息
    packageInfo = await PackageInfo.fromPlatform();
    //统计
    // await Firebase.initializeApp();
    // analytics = FirebaseAnalytics.instance;
    //路由
    routerConfig = AppRouter.configureRouters();
    //屏幕方向
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    EasyRefresh.defaultHeaderBuilder = () => ClassicHeader(
          dragText: S.current.pullToRefresh,
          armedText: S.current.releaseReady,
          readyText: S.current.releaseReady,
          processingText: S.current.refreshing,
          processedText: S.current.succeeded,
          noMoreText: S.current.noMore,
          failedText: S.current.failed,
          messageText: S.current.lastUpdatedAt,
        );
    EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
          dragText: S.current.pullToLoad,
          armedText: S.current.releaseReady,
          readyText: S.current.loading,
          processingText: S.current.loading,
          processedText: S.current.succeeded,
          noMoreText: S.current.noMore,
          failedText: S.current.failed,
          messageText: S.current.lastUpdatedAt,
        );
  }
}
