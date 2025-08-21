// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int,
      username: json['username'] as String,
      status: json['status'] as int?,
      mobile: json['mobile'] as String?,
      mobileValidated: json['mobileValidated'] as int?,
      email: json['email'] as String?,
      emailValidated: json['emailValidated'] as int?,
      sex: json['sex'] as int?,
      qq: json['qq'] as String?,
      avatar: json['avatar'] as String?,
      intro: json['intro'] as String?,
      lastLogin: json['lastLogin'] as String?,
      lastIp: json['lastIp'] as String?,
      lastIpPort: json['lastIpPort'] as int?,
      loginNum: json['loginNum'] as int?,
      points: json['points'] as int?,
      money: json['money'] as String?,
      usedMoney: json['usedMoney'] as String?,
      level: json['level'] as int?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'status': instance.status,
      'mobile': instance.mobile,
      'mobileValidated': instance.mobileValidated,
      'email': instance.email,
      'emailValidated': instance.emailValidated,
      'sex': instance.sex,
      'qq': instance.qq,
      'avatar': instance.avatar,
      'intro': instance.intro,
      'lastLogin': instance.lastLogin,
      'lastIp': instance.lastIp,
      'lastIpPort': instance.lastIpPort,
      'loginNum': instance.loginNum,
      'points': instance.points,
      'money': instance.money,
      'usedMoney': instance.usedMoney,
      'level': instance.level,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };
