// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$$_ArticleFromJson(Map<String, dynamic> json) => _$_Article(
      id: json['id'] as int,
      pid: json['pid'] as int,
      userId: json['userId'] as int?,
      title: json['title'] as String,
      author: json['author'] as String?,
      keywords: json['keywords'] as String?,
      from: json['from'] as String?,
      fromUrl: json['fromUrl'] as String?,
      thumbnail: json['thumbnail'] as String?,
      description: json['description'] as String?,
      status: json['status'] as int?,
      userPublish: json['userPublish'] as int?,
      likeNum: json['likeNum'] as int?,
      viewNum: json['viewNum'] as int?,
      commentNum: json['commentNum'] as int?,
      sharedNum: json['sharedNum'] as int?,
      redirect: json['redirect'] as int?,
      content: json['content'] as String?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pid': instance.pid,
      'userId': instance.userId,
      'title': instance.title,
      'author': instance.author,
      'keywords': instance.keywords,
      'from': instance.from,
      'fromUrl': instance.fromUrl,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'status': instance.status,
      'userPublish': instance.userPublish,
      'likeNum': instance.likeNum,
      'viewNum': instance.viewNum,
      'commentNum': instance.commentNum,
      'sharedNum': instance.sharedNum,
      'redirect': instance.redirect,
      'content': instance.content,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'user': instance.user,
    };
