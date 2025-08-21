/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// id : 96
/// title : ""
/// content : "ssssssssss"
/// fromUid : 0
/// toUid : 3
/// isSystem : "是"
/// isRead : 0
/// createTime : "2020-02-13 12:38:21"
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message(
      {required int id,
      required String title,
      String? content,
      int? fromUid,
      int? toUid,
      String? isSystem,
      required int isRead,
      String? createTime}) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
