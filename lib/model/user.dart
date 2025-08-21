/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// id : 1
/// username : "624c3e78-ff5f-4fb5-8a21-d5c23864610c"
/// status : 1
/// mobile : "13853893418"
/// mobileValidated : 1
/// email : ""
/// emailValidated : 0
/// sex : 0
/// birthday : "2021-07-27 05:06:37"
/// qq : ""
/// avatar : ""
/// lastLogin : "2021-07-27 05:06:37"
/// lastIp : "192.168.31.88"
/// lastIpPort : "13231"
/// loginNum : 7
/// points : 0
/// money : "0.00"
/// frozenMoney : "0.00"
/// usedMoney : "0.00"
/// level : 1
/// createTime : "2021-07-26 01:43:28"
/// updateTime : "2021-07-27 05:06:37"
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {required int id,
      required String username,
      int? status,
      String? mobile,
      int? mobileValidated,
      String? email,
      int? emailValidated,
      int? sex,
      String? qq,
      String? avatar,
      String? intro,
      String? lastLogin,
      String? lastIp,
      int? lastIpPort,
      int? loginNum,
      int? points,
      String? money,
      String? usedMoney,
      int? level,
      String? createTime,
      String? updateTime}) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
