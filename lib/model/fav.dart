/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// id : 3
/// userId : 1
/// infoId : 117
/// infoTable : ""
/// createTime : "2021-08-06 08:34:30"
/// videoInfo : {"id":117,"pid":12,"videoUrl":"https://jsmov2.a.yximgs.com/upic/2018/12/05/19/BMjAxODEyMDUxOTQ4MDdfNjIzMjAzNDEwXzkyMzA4NDQwMjdfMV8z_b_B7631dbf4e30fc40ca9010c20e860ea9c.mp4","viewNum":204,"likeNum":12,"commentNum":0,"sharedNum":0,"createTime":"2021-07-23 04:19:09"}
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/video.dart';

part 'fav.freezed.dart';
part 'fav.g.dart';

@freezed
class Fav with _$Fav {
  const factory Fav(
      {required int id,
      required int userId,
      required int infoId,
      String? infoTable,
      String? createTime,
      Video? videoInfo}) = _Fav;

  factory Fav.fromJson(Map<String, Object?> json) => _$FavFromJson(json);
}
