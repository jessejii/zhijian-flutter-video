/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameters.freezed.dart';




@freezed
class HomeVideoListParameters with _$HomeVideoListParameters {
  const factory HomeVideoListParameters(int pid, {String? searchKey}) =
  _HomeVideoListParameters;
}

@freezed
class ArticleListParameters with _$ArticleListParameters {
  const factory ArticleListParameters(int pid, {int? uid}) =
      _ArticleListParameters;
}

@freezed
class CommentParameters with _$CommentParameters {
  const factory CommentParameters(int infoId, String infoControl) =
      _CommentParameters;
}

@freezed
class VideoRefreshListParameters with _$VideoRefreshListParameters {
  const factory VideoRefreshListParameters(int pid, {int? uid}) =
      _VideoRefreshListParameters;
}
