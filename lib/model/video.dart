/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// id : 22
/// pid : 3
/// userId : 777
/// title : "标题"
/// thumbnail : "https://gimg0.baidu.com/1.jpg"
/// author : "作者"
/// keywords : ""
/// from : "好看视频"
/// fromUrl : "https://haokan.baidu.com/"
/// status : 1
/// userPublish : 0
/// videoUrl : "https://haokan.baidu.com/123.mp4"
/// viewNum : 2
/// likeNum : 46
/// commentNum : 10
/// sharedNum : 0
/// redirect : 0
/// md5 : "ba2ffb391557ade39194daad1a920a32"
/// description : ""
/// createTime : "2021-09-26 04:56:41"
/// updateTime : "2021-09-28 23:12:30"
/// user : {"id":777,"username":"永恒是什么","intro":""}
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/user.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video(
      {required int id,
      required int pid,
      int? userId,
      required String title,
      String? thumbnail,
      String? author,
      String? keywords,
      String? from,
      String? fromUrl,
      int? status,
      int? userPublish,
      required String videoUrl,
      int? viewNum,
      int? likeNum,
      int? commentNum,
      int? sharedNum,
      int? redirect,
      String? md5,
      String? description,
      String? createTime,
      String? updateTime,
      User? user}) = _Video;

  factory Video.fromJson(Map<String, Object?> json) => _$VideoFromJson(json);
}
