/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// id : 51
/// userId : 1
/// subUserId : 2
/// createTime : "2021-09-30 03:11:46"
/// updateTime : "2021-09-30 03:11:46"
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_friend.freezed.dart';
part 'user_friend.g.dart';

@freezed
class UserFriend with _$UserFriend {
  const factory UserFriend(
      {required int id,
      required int userId,
      required int subUserId,
      String? createTime,
      String? updateTime}) = _UserFriend;

  factory UserFriend.fromJson(Map<String, Object?> json) =>
      _$UserFriendFromJson(json);
}
