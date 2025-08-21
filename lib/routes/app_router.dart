/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/application.dart';
import '../utils/config.dart';
import '../view/article_details_page.dart';
import '../view/empty_page.dart';
import '../view/history_page.dart';
import '../view/home_page.dart';
import '../view/landscape_video_details_page.dart';
import '../view/search_page.dart';
import '../view/setting_about_page.dart';
import '../view/setting_page.dart';
import '../view/setting_theme_page.dart';
import '../view/setting_young_page.dart';
import '../view/splash_page.dart';
import '../view/test_page.dart';
import '../view/user_account_avatar_page.dart';
import '../view/user_account_page.dart';
import '../view/user_account_username_page.dart';
import '../view/user_fav_page.dart';
import '../view/user_fav_show_page.dart';
import '../view/user_login_page.dart';
import '../view/user_message_page.dart';
import '../view/user_show_page.dart';
import '../view/web_view_page.dart';

class AppRouter {
  static GoRouter configureRouters() {
    return GoRouter(
      initialLocation: Routes.splash.fullPath,
      //注册路由观察者
      observers: [
        BotToastNavigatorObserver(),
        //谷歌统计
        // FirebaseAnalyticsObserver(analytics: Application.analytics),
        // MyNavObserver(),
      ],
      //空路由
      errorBuilder: (_, GoRouterState state) => const EmptyPage(),
      routes: <GoRoute>[
        //起始页
        GoRoute(
          path: Routes.splash.fullPath,
          name: Routes.splash.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: SplashPage()),
        ),
        GoRoute(
          path: Routes.test.fullPath,
          name: Routes.test.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: TestPage()),
        ),
        GoRoute(
          path: Routes.webView.fullPath,
          name: Routes.webView.name,
          pageBuilder: (_, GoRouterState state) => CupertinoPage(
              child: WebViewPage(params: state.uri.queryParameters)),
        ),
        //首页
        GoRoute(
          path: Routes.home.fullPath,
          name: Routes.home.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: HomePage()),
        ),

        GoRoute(
          path: Routes.settingAbout.fullPath,
          name: Routes.settingAbout.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: SettingAboutPage()),
        ),
        GoRoute(
          path: Routes.userLogin.fullPath,
          name: Routes.userLogin.name,
          pageBuilder: (_, GoRouterState state) => const MaterialPage(
              child: UserLoginPage(), fullscreenDialog: true),
        ),
        GoRoute(
          path: Routes.userShow.fullPath,
          name: Routes.userShow.name,
          pageBuilder: (_, GoRouterState state) => CupertinoPage(
              child: UserShowPage(params: state.uri.queryParameters),
              maintainState: false),
        ),
        GoRoute(
          path: Routes.userMessage.fullPath,
          name: Routes.userMessage.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: UserMessagePage()),
        ),
        GoRoute(
          path: Routes.userHistory.fullPath,
          name: Routes.userHistory.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: HistoryPage()),
        ),
        GoRoute(
          path: Routes.userFav.fullPath,
          name: Routes.userFav.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: UserFavPage()),
          redirect: (context, state) {
            //跳转登录页
            if (Application.prefs.get(Config.KUSER) == null) {
              return Routes.userLogin.fullPath;
            }
            return null;
          },
        ),
        GoRoute(
          path: Routes.userFavShow.fullPath,
          name: Routes.userFavShow.name,
          pageBuilder: (_, GoRouterState state) => CupertinoPage(
              child: UserFavShowPage(params: state.uri.queryParameters)),
        ),
        GoRoute(
          path: Routes.userAccount.fullPath,
          name: Routes.userAccount.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: UserAccountPage()),
        ),
        GoRoute(
          path: Routes.userAccountUsername.fullPath,
          name: Routes.userAccountUsername.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: UserAccountUsernamePage()),
        ),
        GoRoute(
          path: Routes.userAccountAvatar.fullPath,
          name: Routes.userAccountAvatar.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: UserAccountAvatarPage()),
        ),
        GoRoute(
          path: Routes.setting.fullPath,
          name: Routes.setting.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: SettingPage()),
        ),
        GoRoute(
          path: Routes.settingYoung.fullPath,
          name: Routes.settingYoung.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: SettingYoungPage()),
        ),
        GoRoute(
          path: Routes.settingTheme.fullPath,
          name: Routes.settingTheme.name,
          pageBuilder: (_, GoRouterState state) =>
              const CupertinoPage(child: SettingThemePage()),
        ),
        GoRoute(
          path: Routes.videoDetails.fullPath,
          name: Routes.videoDetails.name,
          pageBuilder: (_, GoRouterState state) => CupertinoPage(
            child: LandscapeVideoDetailsPage(
                extra: state.extra, key: ValueKey(state.extra)),
          ),
        ),
        GoRoute(
          path: Routes.articleDetails.fullPath,
          name: Routes.articleDetails.name,
          pageBuilder: (_, GoRouterState state) => CupertinoPage(
            child: ArticleDetailsPage(extra: state.extra),
          ),
        ),
        GoRoute(
          path: Routes.search.fullPath,
          name: Routes.search.name,
          pageBuilder: (_, GoRouterState state) => CupertinoPage(
            child: SearchPage(),
          ),
        ),
      ],
    );
  }
}
