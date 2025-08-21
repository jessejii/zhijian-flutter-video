/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';
import '../provider/provider_widget.dart';
import '../view/article_page.dart';
import '../view/landscape_video_page.dart';
import '../view/portrait_video_page.dart';
import '../view/user_page.dart';
import '../viewmodel/app_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _lastPressed;

  final ValueNotifier<int> _index = ValueNotifier(0);

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: S.current.home,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.video_collection),
      label: S.current.video,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.find_in_page_sharp),
      label: S.current.find,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people_alt),
      label: S.current.mine,
    ),
  ];

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AppModel>(
        provider: appProvider,
        onModelReady: (model) async {
          await model.checkAppUpdate(context,mounted);

          // await model.checkYoung(context);
        },
        builder: (context, model, ref, child) {
          return Scaffold(
              body: WillPopScope(
                onWillPop: () async {
                  if (_lastPressed == null ||
                      DateTime.now().difference(_lastPressed!) >
                          Duration(seconds: 1)) {
                    //两次点击间隔超过1秒则重新计时
                    _lastPressed = DateTime.now();
                    return false;
                  }
                  await _showExitApp();
                  return false;
                },
                child: NotificationListener<OverscrollIndicatorNotification>(
                  //去掉阴影
                  onNotification:
                      (OverscrollIndicatorNotification? overscroll) {
                    overscroll!.disallowIndicator();
                    return true;
                  },
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) => _index.value = value,
                    children: [
                      LandscapeVideoPage(appModel: model),
                      PortraitVideoPage(appModel: model),
                      ArticlePage(appModel: model),
                      UserPage(),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ValueListenableBuilder<int>(
                valueListenable: _index,
                builder: (BuildContext context, int value, Widget? child) {
                  return BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: 30.w,
                    unselectedFontSize: 30.w,
                    iconSize: 50.w,
                    items: bottomItems,
                    currentIndex: value,
                    onTap: (index) {
                      if (index == value) {
                        switch (index) {
                          case 0:
                            model.refreshLandscapeList();
                            break;
                          case 1:
                            model.refreshPortraitList();
                            break;
                            case 2:
                            model.refreshArticleList();
                            break;
                        }
                      } else {
                        _index.value = index;
                        _pageController.jumpToPage(index);
                      }
                    },
                  );
                },
              ));
        });
  }

// 弹出对话框
  Future<bool?> _showExitApp() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要退出应用吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("退出"),
              onPressed: () async {
                await SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop');
              },
            ),
            TextButton(
              child: Text("返回"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
