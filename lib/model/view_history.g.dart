// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ViewHistory _$$_ViewHistoryFromJson(Map<String, dynamic> json) =>
    _$_ViewHistory(
      id: json['id'] as String,
      title: json['title'] as String,
      infoCid: json['infoCid'] as int?,
      infoId: json['infoId'] as int?,
      author: json['author'] as String?,
      viewNum: json['viewNum'] as int?,
      favTime: json['favTime'] as String?,
      thumbnail: json['thumbnail'] as String?,
      videoUrl: json['videoUrl'] as String?,
    );

Map<String, dynamic> _$$_ViewHistoryToJson(_$_ViewHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'infoCid': instance.infoCid,
      'infoId': instance.infoId,
      'author': instance.author,
      'viewNum': instance.viewNum,
      'favTime': instance.favTime,
      'thumbnail': instance.thumbnail,
      'videoUrl': instance.videoUrl,
    };
