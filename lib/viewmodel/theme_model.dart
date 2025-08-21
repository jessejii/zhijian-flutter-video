/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generated/l10n.dart';
import '../provider/view_state_model.dart';
import '../utils/application.dart';

Map<String, FlexScheme> _selTheme = {
  'material': FlexScheme.material,
  'materialHc': FlexScheme.materialHc,
  'blue': FlexScheme.blue,
  'indigo': FlexScheme.indigo,
  'hippieBlue': FlexScheme.hippieBlue,
  'aquaBlue': FlexScheme.aquaBlue,
  'brandBlue': FlexScheme.brandBlue,
  'deepBlue': FlexScheme.deepBlue,
  'sakura': FlexScheme.sakura,
  'mandyRed': FlexScheme.mandyRed,
  'red': FlexScheme.red,
  'redWine': FlexScheme.redWine,
  'purpleBrown': FlexScheme.purpleBrown,
  'green': FlexScheme.green,
  'money': FlexScheme.money,
  'jungle': FlexScheme.jungle,
  'greyLaw': FlexScheme.greyLaw,
  'wasabi': FlexScheme.wasabi,
  'gold': FlexScheme.gold,
  'mango': FlexScheme.mango,
  'amber': FlexScheme.amber,
  'vesuviusBurn': FlexScheme.vesuviusBurn,
  'deepPurple': FlexScheme.deepPurple,
  'ebonyClay': FlexScheme.ebonyClay,
  'barossa': FlexScheme.barossa,
  'shark': FlexScheme.shark,
  'bigStone': FlexScheme.bigStone,
  'damask': FlexScheme.damask,
  'bahamaBlue': FlexScheme.bahamaBlue,
  'mallardGreen': FlexScheme.mallardGreen,
  'espresso': FlexScheme.espresso,
  'outerSpace': FlexScheme.outerSpace,
  'blueWhale': FlexScheme.blueWhale,
  'sanJuanBlue': FlexScheme.sanJuanBlue,
  'rosewood': FlexScheme.rosewood,
  'blumineBlue': FlexScheme.blumineBlue,
  'flutterDash': FlexScheme.flutterDash,
  'materialBaseline': FlexScheme.materialBaseline,
  'verdunHemlock': FlexScheme.verdunHemlock,
  'dellGenoa': FlexScheme.dellGenoa,
  'redM3': FlexScheme.redM3,
  'pinkM3': FlexScheme.pinkM3,
  'purpleM3': FlexScheme.purpleM3,
  'indigoM3': FlexScheme.indigoM3,
  'blueM3': FlexScheme.blueM3,
  'cyanM3': FlexScheme.cyanM3,
  'tealM3': FlexScheme.tealM3,
  'greenM3': FlexScheme.greenM3,
  'limeM3': FlexScheme.limeM3,
  'yellowM3': FlexScheme.yellowM3,
  'orangeM3': FlexScheme.orangeM3,
  'deepOrangeM3': FlexScheme.deepOrangeM3,
};
final themeProvider = ChangeNotifierProvider((ref) => ThemeModel());

class ThemeModel extends ViewStateModel {
  ThemeModel() {
    _themeModelFoo();
    getColorScheme();
  }

  //系统模式
  ThemeMode? _themeMode;

  ThemeMode get themeMode => _themeMode!;

  //颜色主题
  FlexScheme? _scheme;

  FlexScheme? get scheme => _scheme;

  //获取主题模式
  void _themeModelFoo() {
    int localModel = Application.prefs.get('localModel') ?? 0;
    switch (localModel) {
      case 1:
        _themeMode = ThemeMode.light;
        break;
      case 2:
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }
  }

  //设置主题模式
  Future<void> setThemeModelFoo(int index) async {
    await Application.prefs.put('localModel', index);
    _themeModelFoo();
    notifyListeners();
  }

  //获取颜色主题
  getColorScheme() {
    String localColorSchemeName =
        Application.prefs.get('colorScheme') ?? 'shark';
    _scheme = _selTheme[localColorSchemeName];
  }

  //设置不同主题
  Future<void> setColorScheme(String name) async {
    _scheme = _selTheme[name];
    await Application.prefs.put('colorScheme', name);
    notifyListeners();
  }
}

final themeListProvider = ChangeNotifierProvider((ref) => ThemeListModel());

class ThemeListModel extends ViewStateModel {
  List<Map<String, dynamic>> listData = [];

  void initList() {
    _selTheme.forEach((key, FlexScheme value) {
      Map<String, dynamic> s = {
        'color': FlexColor.schemesWithCustom[value]?.light.primary,
        //!To-do dart不支持动态对象属性和反射 在研究下怎么用动态变量属性 Fix-Me 目前名称一致 等待修改
        'title': S.current.style(value),
        'name': key.toString()
      };
      listData.add(s);
    });
    notifyListeners();
  }
}
