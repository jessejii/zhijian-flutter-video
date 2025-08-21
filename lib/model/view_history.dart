/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_history.freezed.dart';
part 'view_history.g.dart';

@freezed
class ViewHistory with _$ViewHistory {
  const factory ViewHistory({
    required String id,
    required String title,
    int? infoCid,
    int? infoId,
    String? author,
    int? viewNum,
    String? favTime,
    String? thumbnail,
    String? videoUrl,
  }) = _ViewHistory;

  factory ViewHistory.fromJson(Map<String, dynamic> json) =>
      _$ViewHistoryFromJson(json);
}
