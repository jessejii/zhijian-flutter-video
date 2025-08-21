/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `video`
  String get video {
    return Intl.message(
      'video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `find`
  String get find {
    return Intl.message(
      'find',
      name: 'find',
      desc: '',
      args: [],
    );
  }

  /// `mine`
  String get mine {
    return Intl.message(
      'mine',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `news`
  String get news {
    return Intl.message(
      'news',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `recommend`
  String get recommend {
    return Intl.message(
      'recommend',
      name: 'recommend',
      desc: '',
      args: [],
    );
  }

  /// `member center`
  String get memberCenter {
    return Intl.message(
      'member center',
      name: 'memberCenter',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get Dark {
    return Intl.message(
      'Dark',
      name: 'Dark',
      desc: '',
      args: [],
    );
  }

  /// `Pull to refresh`
  String get pullToRefresh {
    return Intl.message(
      'Pull to refresh',
      name: 'pullToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Release ready`
  String get releaseReady {
    return Intl.message(
      'Release ready',
      name: 'releaseReady',
      desc: '',
      args: [],
    );
  }

  /// `refreshing...`
  String get refreshing {
    return Intl.message(
      'refreshing...',
      name: 'refreshing',
      desc: '',
      args: [],
    );
  }

  /// `succeeded`
  String get succeeded {
    return Intl.message(
      'succeeded',
      name: 'succeeded',
      desc: '',
      args: [],
    );
  }

  /// `No more`
  String get noMore {
    return Intl.message(
      'No more',
      name: 'noMore',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Last updated at %T`
  String get lastUpdatedAt {
    return Intl.message(
      'Last updated at %T',
      name: 'lastUpdatedAt',
      desc: '',
      args: [],
    );
  }

  /// `Pull to load`
  String get pullToLoad {
    return Intl.message(
      'Pull to load',
      name: 'pullToLoad',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `{section, select, material {material} materialHc {materialHc} blue {blue} indigo {indigo} hippieBlue {hippieBlue} aquaBlue {aquaBlue} brandBlue {brandBlue} deepBlue {deepBlue} sakura {sakura} mandyRed {mandyRed} red {red} redWine {redWine} purpleBrown {purpleBrown} green {green} money {money} jungle {jungle} greyLaw {greyLaw} wasabi {wasabi} gold {gold} mango {mango} amber {amber} vesuviusBurn {vesuviusBurn} deepPurple {deepPurple} ebonyClay {ebonyClay} barossa {barossa} shark {shark} bigStone {bigStone} damask {damask} bahamaBlue {bahamaBlue} mallardGreen {mallardGreen} espresso {espresso} outerSpace {outerSpace} blueWhale {blueWhale} sanJuanBlue {sanJuanBlue} rosewood {rosewood} blumineBlue {blumineBlue} flutterDash {flutterDash} materialBaseline {materialBaseline} verdunHemlock {verdunHemlock} dellGenoa {dellGenoa} redM3 {redM3} pinkM3 {pinkM3} purpleM3 {purpleM3} indigoM3 {indigoM3} blueM3 {blueM3} cyanM3 {cyanM3} tealM3 {tealM3} greenM3 {greenM3} limeM3 {limeM3} yellowM3 {yellowM3} orangeM3 {orangeM3} deepOrangeM3 {deepOrangeM3} other {Section}}`
  String style(Object section) {
    return Intl.select(
      section,
      {
        'material': 'material',
        'materialHc': 'materialHc',
        'blue': 'blue',
        'indigo': 'indigo',
        'hippieBlue': 'hippieBlue',
        'aquaBlue': 'aquaBlue',
        'brandBlue': 'brandBlue',
        'deepBlue': 'deepBlue',
        'sakura': 'sakura',
        'mandyRed': 'mandyRed',
        'red': 'red',
        'redWine': 'redWine',
        'purpleBrown': 'purpleBrown',
        'green': 'green',
        'money': 'money',
        'jungle': 'jungle',
        'greyLaw': 'greyLaw',
        'wasabi': 'wasabi',
        'gold': 'gold',
        'mango': 'mango',
        'amber': 'amber',
        'vesuviusBurn': 'vesuviusBurn',
        'deepPurple': 'deepPurple',
        'ebonyClay': 'ebonyClay',
        'barossa': 'barossa',
        'shark': 'shark',
        'bigStone': 'bigStone',
        'damask': 'damask',
        'bahamaBlue': 'bahamaBlue',
        'mallardGreen': 'mallardGreen',
        'espresso': 'espresso',
        'outerSpace': 'outerSpace',
        'blueWhale': 'blueWhale',
        'sanJuanBlue': 'sanJuanBlue',
        'rosewood': 'rosewood',
        'blumineBlue': 'blumineBlue',
        'flutterDash': 'flutterDash',
        'materialBaseline': 'materialBaseline',
        'verdunHemlock': 'verdunHemlock',
        'dellGenoa': 'dellGenoa',
        'redM3': 'redM3',
        'pinkM3': 'pinkM3',
        'purpleM3': 'purpleM3',
        'indigoM3': 'indigoM3',
        'blueM3': 'blueM3',
        'cyanM3': 'cyanM3',
        'tealM3': 'tealM3',
        'greenM3': 'greenM3',
        'limeM3': 'limeM3',
        'yellowM3': 'yellowM3',
        'orangeM3': 'orangeM3',
        'deepOrangeM3': 'deepOrangeM3',
        'other': 'Section',
      },
      name: 'style',
      desc: '',
      args: [section],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
