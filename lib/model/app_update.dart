/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// appVersion : "1.1"
/// appUrl : "https://www.baidu.com/app.apk"
/// appMust : 1
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update.freezed.dart';
part 'app_update.g.dart';

@freezed
class AppUpdate with _$AppUpdate {
  const factory AppUpdate({
    required String appVersion,
    required String appUrl,
    required int appMust,
  }) = _AppUpdate;

  factory AppUpdate.fromJson(Map<String, Object?> json) =>
      _$AppUpdateFromJson(json);
}
