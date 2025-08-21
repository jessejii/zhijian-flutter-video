// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Video _$$_VideoFromJson(Map<String, dynamic> json) => _$_Video(
      id: json['id'] as int,
      pid: json['pid'] as int,
      userId: json['userId'] as int?,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String?,
      author: json['author'] as String?,
      keywords: json['keywords'] as String?,
      from: json['from'] as String?,
      fromUrl: json['fromUrl'] as String?,
      status: json['status'] as int?,
      userPublish: json['userPublish'] as int?,
      videoUrl: json['videoUrl'] as String,
      viewNum: json['viewNum'] as int?,
      likeNum: json['likeNum'] as int?,
      commentNum: json['commentNum'] as int?,
      sharedNum: json['sharedNum'] as int?,
      redirect: json['redirect'] as int?,
      md5: json['md5'] as String?,
      description: json['description'] as String?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_VideoToJson(_$_Video instance) => <String, dynamic>{
      'id': instance.id,
      'pid': instance.pid,
      'userId': instance.userId,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'author': instance.author,
      'keywords': instance.keywords,
      'from': instance.from,
      'fromUrl': instance.fromUrl,
      'status': instance.status,
      'userPublish': instance.userPublish,
      'videoUrl': instance.videoUrl,
      'viewNum': instance.viewNum,
      'likeNum': instance.likeNum,
      'commentNum': instance.commentNum,
      'sharedNum': instance.sharedNum,
      'redirect': instance.redirect,
      'md5': instance.md5,
      'description': instance.description,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'user': instance.user,
    };
