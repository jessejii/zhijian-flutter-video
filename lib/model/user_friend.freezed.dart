// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_friend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserFriend _$UserFriendFromJson(Map<String, dynamic> json) {
  return _UserFriend.fromJson(json);
}

/// @nodoc
mixin _$UserFriend {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get subUserId => throw _privateConstructorUsedError;
  String? get createTime => throw _privateConstructorUsedError;
  String? get updateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserFriendCopyWith<UserFriend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFriendCopyWith<$Res> {
  factory $UserFriendCopyWith(
          UserFriend value, $Res Function(UserFriend) then) =
      _$UserFriendCopyWithImpl<$Res, UserFriend>;
  @useResult
  $Res call(
      {int id,
      int userId,
      int subUserId,
      String? createTime,
      String? updateTime});
}

/// @nodoc
class _$UserFriendCopyWithImpl<$Res, $Val extends UserFriend>
    implements $UserFriendCopyWith<$Res> {
  _$UserFriendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? subUserId = null,
    Object? createTime = freezed,
    Object? updateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      subUserId: null == subUserId
          ? _value.subUserId
          : subUserId // ignore: cast_nullable_to_non_nullable
              as int,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserFriendCopyWith<$Res>
    implements $UserFriendCopyWith<$Res> {
  factory _$$_UserFriendCopyWith(
          _$_UserFriend value, $Res Function(_$_UserFriend) then) =
      __$$_UserFriendCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int userId,
      int subUserId,
      String? createTime,
      String? updateTime});
}

/// @nodoc
class __$$_UserFriendCopyWithImpl<$Res>
    extends _$UserFriendCopyWithImpl<$Res, _$_UserFriend>
    implements _$$_UserFriendCopyWith<$Res> {
  __$$_UserFriendCopyWithImpl(
      _$_UserFriend _value, $Res Function(_$_UserFriend) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? subUserId = null,
    Object? createTime = freezed,
    Object? updateTime = freezed,
  }) {
    return _then(_$_UserFriend(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      subUserId: null == subUserId
          ? _value.subUserId
          : subUserId // ignore: cast_nullable_to_non_nullable
              as int,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserFriend with DiagnosticableTreeMixin implements _UserFriend {
  const _$_UserFriend(
      {required this.id,
      required this.userId,
      required this.subUserId,
      this.createTime,
      this.updateTime});

  factory _$_UserFriend.fromJson(Map<String, dynamic> json) =>
      _$$_UserFriendFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final int subUserId;
  @override
  final String? createTime;
  @override
  final String? updateTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserFriend(id: $id, userId: $userId, subUserId: $subUserId, createTime: $createTime, updateTime: $updateTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserFriend'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('subUserId', subUserId))
      ..add(DiagnosticsProperty('createTime', createTime))
      ..add(DiagnosticsProperty('updateTime', updateTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserFriend &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.subUserId, subUserId) ||
                other.subUserId == subUserId) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, subUserId, createTime, updateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserFriendCopyWith<_$_UserFriend> get copyWith =>
      __$$_UserFriendCopyWithImpl<_$_UserFriend>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserFriendToJson(
      this,
    );
  }
}

abstract class _UserFriend implements UserFriend {
  const factory _UserFriend(
      {required final int id,
      required final int userId,
      required final int subUserId,
      final String? createTime,
      final String? updateTime}) = _$_UserFriend;

  factory _UserFriend.fromJson(Map<String, dynamic> json) =
      _$_UserFriend.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  int get subUserId;
  @override
  String? get createTime;
  @override
  String? get updateTime;
  @override
  @JsonKey(ignore: true)
  _$$_UserFriendCopyWith<_$_UserFriend> get copyWith =>
      throw _privateConstructorUsedError;
}
