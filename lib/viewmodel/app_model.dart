/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhijian/generated/assets.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../model/app_update.dart';
import '../provider/view_state_model.dart';
import '../utils/application.dart';
import '../widget/update_pop.dart';

final appProvider = ChangeNotifierProvider((ref) => AppModel());

class AppModel extends ViewStateModel {
  AppModel() : super(viewState: ViewState.busy);

  EasyRefreshController? refreshController;
  EasyRefreshController? articleRefreshController;
  EasyRefreshController? portraitRefreshController;

  //刷新横视频
  void refreshLandscapeList() {
    refreshController?.callRefresh(overOffset: 10);
  }

  //刷新小视频
  void setLandscapeRefreshController(EasyRefreshController? controller) {
    refreshController = controller;
  }

  //tabbar刷新文章列表
  void setArticleRefreshController(EasyRefreshController? controller) {
    articleRefreshController = controller;
  }

  void refreshArticleList() {
    articleRefreshController?.callRefresh(overOffset: 10);
  }

  //protrait视频
  void setPortraitRefreshController(EasyRefreshController? controller) {
    portraitRefreshController = controller;
  }

  void refreshPortraitList() {
    // print("要刷新的:${portraitRefreshController.hashCode}");
    portraitRefreshController?.callRefresh(overOffset: 10);
  }

  //model中的不应涉及显示组件,暂停这样吧.
  //检查更新
  Future checkAppUpdate(BuildContext ctx, bool mounted,
      [bool show = false]) async {
    if (!Platform.isAndroid) {
      return;
    }
    HttpResponse res = await Api.appUpdate();
    if (!res.ok) {
      setError(res.error);
      return;
    }
    AppUpdate data = AppUpdate.fromJson(res.data);

    bool canPop = data.appMust != 0;
    if (data.appVersion != Application.packageInfo.version) {
      // await Future.delayed(Duration(seconds: 5));
      if (!mounted) return;
      await showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (context) => UpdatePop(canPop: canPop, appUpdate: data),
      );
    }
    if (show) {
      // print('turew');
      BotToast.showText(text: "已为最新版本", align: Alignment.center);
    }
  }

  //青少年模式
  Future<void> checkYoung(BuildContext context) async {
    bool? isY = Application.prefs.get('young');
    if (isY != true) {
      showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    Assets.imagesUmbrella,
                    width: 230.w,
                    height: 187.w,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "青少年模式",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 32.w, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '精选了一批教育类、知识类内容星现在首页,合理控制观看内容,时长.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 28.w),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    context.pushNamed(Routes.settingYoung.name);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "开启青少年模式",
                        style: TextStyle(fontSize: 26.w, color: Colors.green),
                      ),
                      Icon(Icons.chevron_right, color: Colors.green)
                    ],
                  ),
                ),
                SizedBox(
                  width: 500.w,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("我知道了", style: TextStyle(color: Colors.green)),
                  ),
                ),
                SizedBox(height: 20.w),
              ],
            ),
          );
        },
      );
    }
  }
}
