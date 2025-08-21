// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Fav _$$_FavFromJson(Map<String, dynamic> json) => _$_Fav(
      id: json['id'] as int,
      userId: json['userId'] as int,
      infoId: json['infoId'] as int,
      infoTable: json['infoTable'] as String?,
      createTime: json['createTime'] as String?,
      videoInfo: json['videoInfo'] == null
          ? null
          : Video.fromJson(json['videoInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FavToJson(_$_Fav instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'infoId': instance.infoId,
      'infoTable': instance.infoTable,
      'createTime': instance.createTime,
      'videoInfo': instance.videoInfo,
    };
