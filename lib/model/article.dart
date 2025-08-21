/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/foundation.dart';
/// id : 4
/// pid : 3
/// userId : 2
/// title : "钓鱼人最爱说的三句话，看似合情合理"
/// author : ""
/// keywords : " "
/// from : ""
/// fromUrl : ""
/// thumbnail : ""
/// description : ""
/// status : 1
/// userPublish : 0
/// likeNum : 0
/// viewNum : 9
/// commentNum : 0
/// sharedNum : 0
/// redirect : 0
/// content : ""
/// createTime : "2020-05-29 22:02:02"
/// updateTime : "2021-09-28 22:11:35"
/// user : {"id":2,"username":"jisjian","intro":""}
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/user.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  const factory Article(
      {required int id,
      required int pid,
      int? userId,
      required String title,
      String? author,
      String? keywords,
      String? from,
      String? fromUrl,
      String? thumbnail,
      String? description,
      int? status,
      int? userPublish,
      int? likeNum,
      int? viewNum,
      int? commentNum,
      int? sharedNum,
      int? redirect,
      String? content,
      String? createTime,
      String? updateTime,
      User? user}) = _Article;

  factory Article.fromJson(Map<String, Object?> json) =>
      _$ArticleFromJson(json);
}
