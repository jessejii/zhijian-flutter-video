// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserFriend _$$_UserFriendFromJson(Map<String, dynamic> json) =>
    _$_UserFriend(
      id: json['id'] as int,
      userId: json['userId'] as int,
      subUserId: json['subUserId'] as int,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
    );

Map<String, dynamic> _$$_UserFriendToJson(_$_UserFriend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'subUserId': instance.subUserId,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };
