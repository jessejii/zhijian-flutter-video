// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Fav _$FavFromJson(Map<String, dynamic> json) {
  return _Fav.fromJson(json);
}

/// @nodoc
mixin _$Fav {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get infoId => throw _privateConstructorUsedError;
  String? get infoTable => throw _privateConstructorUsedError;
  String? get createTime => throw _privateConstructorUsedError;
  Video? get videoInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavCopyWith<Fav> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavCopyWith<$Res> {
  factory $FavCopyWith(Fav value, $Res Function(Fav) then) =
      _$FavCopyWithImpl<$Res, Fav>;
  @useResult
  $Res call(
      {int id,
      int userId,
      int infoId,
      String? infoTable,
      String? createTime,
      Video? videoInfo});

  $VideoCopyWith<$Res>? get videoInfo;
}

/// @nodoc
class _$FavCopyWithImpl<$Res, $Val extends Fav> implements $FavCopyWith<$Res> {
  _$FavCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? infoId = null,
    Object? infoTable = freezed,
    Object? createTime = freezed,
    Object? videoInfo = freezed,
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
      infoId: null == infoId
          ? _value.infoId
          : infoId // ignore: cast_nullable_to_non_nullable
              as int,
      infoTable: freezed == infoTable
          ? _value.infoTable
          : infoTable // ignore: cast_nullable_to_non_nullable
              as String?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      videoInfo: freezed == videoInfo
          ? _value.videoInfo
          : videoInfo // ignore: cast_nullable_to_non_nullable
              as Video?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VideoCopyWith<$Res>? get videoInfo {
    if (_value.videoInfo == null) {
      return null;
    }

    return $VideoCopyWith<$Res>(_value.videoInfo!, (value) {
      return _then(_value.copyWith(videoInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FavCopyWith<$Res> implements $FavCopyWith<$Res> {
  factory _$$_FavCopyWith(_$_Fav value, $Res Function(_$_Fav) then) =
      __$$_FavCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int userId,
      int infoId,
      String? infoTable,
      String? createTime,
      Video? videoInfo});

  @override
  $VideoCopyWith<$Res>? get videoInfo;
}

/// @nodoc
class __$$_FavCopyWithImpl<$Res> extends _$FavCopyWithImpl<$Res, _$_Fav>
    implements _$$_FavCopyWith<$Res> {
  __$$_FavCopyWithImpl(_$_Fav _value, $Res Function(_$_Fav) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? infoId = null,
    Object? infoTable = freezed,
    Object? createTime = freezed,
    Object? videoInfo = freezed,
  }) {
    return _then(_$_Fav(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      infoId: null == infoId
          ? _value.infoId
          : infoId // ignore: cast_nullable_to_non_nullable
              as int,
      infoTable: freezed == infoTable
          ? _value.infoTable
          : infoTable // ignore: cast_nullable_to_non_nullable
              as String?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      videoInfo: freezed == videoInfo
          ? _value.videoInfo
          : videoInfo // ignore: cast_nullable_to_non_nullable
              as Video?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Fav with DiagnosticableTreeMixin implements _Fav {
  const _$_Fav(
      {required this.id,
      required this.userId,
      required this.infoId,
      this.infoTable,
      this.createTime,
      this.videoInfo});

  factory _$_Fav.fromJson(Map<String, dynamic> json) => _$$_FavFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final int infoId;
  @override
  final String? infoTable;
  @override
  final String? createTime;
  @override
  final Video? videoInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Fav(id: $id, userId: $userId, infoId: $infoId, infoTable: $infoTable, createTime: $createTime, videoInfo: $videoInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Fav'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('infoId', infoId))
      ..add(DiagnosticsProperty('infoTable', infoTable))
      ..add(DiagnosticsProperty('createTime', createTime))
      ..add(DiagnosticsProperty('videoInfo', videoInfo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Fav &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.infoId, infoId) || other.infoId == infoId) &&
            (identical(other.infoTable, infoTable) ||
                other.infoTable == infoTable) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.videoInfo, videoInfo) ||
                other.videoInfo == videoInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, infoId, infoTable, createTime, videoInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavCopyWith<_$_Fav> get copyWith =>
      __$$_FavCopyWithImpl<_$_Fav>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavToJson(
      this,
    );
  }
}

abstract class _Fav implements Fav {
  const factory _Fav(
      {required final int id,
      required final int userId,
      required final int infoId,
      final String? infoTable,
      final String? createTime,
      final Video? videoInfo}) = _$_Fav;

  factory _Fav.fromJson(Map<String, dynamic> json) = _$_Fav.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  int get infoId;
  @override
  String? get infoTable;
  @override
  String? get createTime;
  @override
  Video? get videoInfo;
  @override
  @JsonKey(ignore: true)
  _$$_FavCopyWith<_$_Fav> get copyWith => throw _privateConstructorUsedError;
}
