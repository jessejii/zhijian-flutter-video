// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      fromUid: json['fromUid'] as int?,
      toUid: json['toUid'] as int?,
      isSystem: json['isSystem'] as String?,
      isRead: json['isRead'] as int,
      createTime: json['createTime'] as String?,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'fromUid': instance.fromUid,
      'toUid': instance.toUid,
      'isSystem': instance.isSystem,
      'isRead': instance.isRead,
      'createTime': instance.createTime,
    };
