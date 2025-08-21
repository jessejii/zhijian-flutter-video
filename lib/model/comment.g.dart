// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as int,
      infoControl: json['infoControl'] as String,
      infoId: json['infoId'] as int,
      content: json['content'] as String,
      userId: json['userId'] as int,
      heartNum: json['heartNum'] as int?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      userAvatar: json['userAvatar'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'infoControl': instance.infoControl,
      'infoId': instance.infoId,
      'content': instance.content,
      'userId': instance.userId,
      'heartNum': instance.heartNum,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'userAvatar': instance.userAvatar,
      'userName': instance.userName,
    };
