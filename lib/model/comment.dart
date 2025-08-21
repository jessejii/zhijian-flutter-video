/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// id : 84
/// infoControl : "video"
/// infoId : 22
/// content : "😆😆😅😅😅😆😆😅😅😅"
/// userId : 1
/// heartNum : 0
/// createTime : "2021-09-16 01:34:37"
/// updateTime : "2021-09-16 01:34:37"
/// userAvatar : "http://xyfile.ddu5.com/file/20210728/f7126d22d3d40574c8c3cf320d5cfe90.jpg"
/// userName : "624c3e78-ff5f-4fb5-8a21-d5c23864610c"
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required int id,
    required String infoControl,
    required int infoId,
    required String content,
    required int userId,
    int? heartNum,
    String? createTime,
    String? updateTime,
    String? userAvatar,
    String? userName,
  }) = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) =>
      _$CommentFromJson(json);
}
