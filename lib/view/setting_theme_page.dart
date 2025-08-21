/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';
import '../provider/provider_widget.dart';
import '../utils/icon_fonts.dart';
import '../viewmodel/theme_model.dart';

class SettingThemePage extends StatefulWidget {
  const SettingThemePage({super.key});

  @override
  createState() => _SettingThemePageState();
}

class _SettingThemePageState extends State<SettingThemePage> {
  @override
  Widget build(BuildContext context) {
    // print('settingpage');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '个性设置',
          style: TextStyle(fontSize: 36.w),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          _themeModeSelect(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('主题色彩',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 28.w)),
                  SizedBox(height: 4),
                  Divider(height: 2),
                ],
              ),
            ),
          ),
          _themeList(),
          //List
        ],
      ),
    );
  }

//这里注意 更换主题后 使用  Theme.of(context) 会导致多次build
  Widget _themeModeSelect() {
    return ProviderWidget<ThemeModel>(
      provider: themeProvider,
      builder: (context, ThemeModel model, ref, child) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.current.theme,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 28.w)),
                SizedBox(
                  width: 440.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => model.setThemeModelFoo(0),
                        child: Column(
                          children: [
                            Container(
                              height: 100.w,
                              width: 140.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).hintColor,
                                    ]),
                              ),
                              child: Icon(
                                IconFonts.auto,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                model.themeMode == ThemeMode.system
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        size: 34.w,
                                      )
                                    : SizedBox(),
                                Text(
                                  S.current.system,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 24.w),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => model.setThemeModelFoo(1),
                        child: Column(
                          children: [
                            Container(
                              height: 100.w,
                              width: 140.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: const [
                                      Color(0xffefefbb),
                                      Color(0xffd4d3dd)
                                    ]),
                              ),
                              child: Icon(
                                IconFonts.sun,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                model.themeMode == ThemeMode.light
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        size: 34.w,
                                      )
                                    : SizedBox(),
                                Text(
                                  S.current.light,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 24.w),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => model.setThemeModelFoo(2),
                        child: Column(
                          children: [
                            Container(
                              height: 100.w,
                              width: 140.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: const [
                                      Color(0xff0f0c29),
                                      Color(0xff302b63),
                                      Color(0xff24243e)
                                    ]),
                              ),
                              child: Icon(
                                IconFonts.night,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                model.themeMode == ThemeMode.dark
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        size: 34.w,
                                      )
                                    : SizedBox(),
                                Text(
                                  S.current.Dark,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 24.w),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _themeList() {
    return ProviderWidget<ThemeListModel>(
      provider: themeListProvider,
      onModelReady: (model) => model.initList(),
      builder: (context, model, ref, child) {
        return SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            //Grid
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //Grid按两列显示
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建子widget
                return GestureDetector(
                  onTap: () => ref
                      .watch(themeProvider)
                      .setColorScheme(model.listData[index]['name']),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: model.listData[index]['color'],
                              borderRadius: BorderRadius.circular(16.w),
                              border: Border.all(
                                color: Colors.redAccent[200]!,
                                // color: Theme.of(context).backgroundColor,
                                width: 2.w,
                              )),
                        ),
                      ),
                      Text(
                        '${model.listData[index]['title']}',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 26.w,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              childCount: model.listData.length,
            ),
          ),
        );
      },
    );
  }
}
