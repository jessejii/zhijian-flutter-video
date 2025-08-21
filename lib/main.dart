/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generated/l10n.dart';
import '../utils/application.dart';
import '../viewmodel/theme_model.dart';

void main() => Application.init().then((_) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
      child: ScreenUtilInit(
          designSize: const Size(750, 1334),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final model = ref.watch<ThemeModel>(themeProvider);
                final lightTheme = FlexThemeData.light(
                  scheme: model.scheme,
                  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                  blendLevel: 7,
                  appBarStyle: FlexAppBarStyle.primary,
                  tabBarStyle: FlexTabBarStyle.universal,
                  subThemesData: const FlexSubThemesData(
                    blendOnLevel: 10,
                    blendOnColors: false,
                    useM2StyleDividerInM3: true,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  visualDensity: FlexColorScheme.comfortablePlatformDensity,
                  useMaterial3: true,
                  swapLegacyOnMaterial3: true,
                );
                final darkTheme = FlexThemeData.dark(
                  scheme: model.scheme,
                  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                  blendLevel: 13,
                  tabBarStyle: FlexTabBarStyle.universal,
                  subThemesData: const FlexSubThemesData(
                    blendOnLevel: 20,
                    useM2StyleDividerInM3: true,
                    tabBarItemSchemeColor: SchemeColor.primary,
                    tabBarUnselectedItemSchemeColor:
                        SchemeColor.onPrimaryContainer,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  visualDensity: FlexColorScheme.comfortablePlatformDensity,
                  useMaterial3: true,
                  swapLegacyOnMaterial3: true,
                );
                return MaterialApp.router(
                  routerConfig: Application.routerConfig,
                  debugShowCheckedModeBanner: false,
                  // 本地化的代理类
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  //我们只支持美国英语和中文简体
                  supportedLocales: S.delegate.supportedLocales,
                  //国际化回调,可以改变默认语言
                  localeResolutionCallback:
                      (Locale? locale, Iterable<Locale> supportedLocales) {
                    var result = supportedLocales.where((element) =>
                        element.languageCode == locale?.languageCode);
                    if (result.isEmpty) {
                      return const Locale('zh');
                    }
                    return locale;
                  },
                  title: '知见',
                  theme: lightTheme.copyWith(
                    inputDecorationTheme:
                        lightTheme.inputDecorationTheme.copyWith(
                      contentPadding: EdgeInsets.zero,
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // 改变这个值来调节半径
                          ),
                        ),
                      ),
                    ),
                  ),
                  darkTheme: darkTheme.copyWith(
                    inputDecorationTheme:
                        darkTheme.inputDecorationTheme.copyWith(
                      contentPadding: EdgeInsets.zero,
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // 改变这个值来调节半径
                          ),
                        ),
                      ),
                    ),
                  ),
                  themeMode: model.themeMode,
                  builder: (context, child) {
                    // print('MaterialApp-builder');
                    child = Application.botToastBuilder(context, child);
                    return child;
                  },
                );
              },
            );
          }),
    );
  }
}
