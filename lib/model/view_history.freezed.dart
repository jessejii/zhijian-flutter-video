// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ViewHistory _$ViewHistoryFromJson(Map<String, dynamic> json) {
  return _ViewHistory.fromJson(json);
}

/// @nodoc
mixin _$ViewHistory {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int? get infoCid => throw _privateConstructorUsedError;
  int? get infoId => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  int? get viewNum => throw _privateConstructorUsedError;
  String? get favTime => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ViewHistoryCopyWith<ViewHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewHistoryCopyWith<$Res> {
  factory $ViewHistoryCopyWith(
          ViewHistory value, $Res Function(ViewHistory) then) =
      _$ViewHistoryCopyWithImpl<$Res, ViewHistory>;
  @useResult
  $Res call(
      {String id,
      String title,
      int? infoCid,
      int? infoId,
      String? author,
      int? viewNum,
      String? favTime,
      String? thumbnail,
      String? videoUrl});
}

/// @nodoc
class _$ViewHistoryCopyWithImpl<$Res, $Val extends ViewHistory>
    implements $ViewHistoryCopyWith<$Res> {
  _$ViewHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? infoCid = freezed,
    Object? infoId = freezed,
    Object? author = freezed,
    Object? viewNum = freezed,
    Object? favTime = freezed,
    Object? thumbnail = freezed,
    Object? videoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      infoCid: freezed == infoCid
          ? _value.infoCid
          : infoCid // ignore: cast_nullable_to_non_nullable
              as int?,
      infoId: freezed == infoId
          ? _value.infoId
          : infoId // ignore: cast_nullable_to_non_nullable
              as int?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      viewNum: freezed == viewNum
          ? _value.viewNum
          : viewNum // ignore: cast_nullable_to_non_nullable
              as int?,
      favTime: freezed == favTime
          ? _value.favTime
          : favTime // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ViewHistoryCopyWith<$Res>
    implements $ViewHistoryCopyWith<$Res> {
  factory _$$_ViewHistoryCopyWith(
          _$_ViewHistory value, $Res Function(_$_ViewHistory) then) =
      __$$_ViewHistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      int? infoCid,
      int? infoId,
      String? author,
      int? viewNum,
      String? favTime,
      String? thumbnail,
      String? videoUrl});
}

/// @nodoc
class __$$_ViewHistoryCopyWithImpl<$Res>
    extends _$ViewHistoryCopyWithImpl<$Res, _$_ViewHistory>
    implements _$$_ViewHistoryCopyWith<$Res> {
  __$$_ViewHistoryCopyWithImpl(
      _$_ViewHistory _value, $Res Function(_$_ViewHistory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? infoCid = freezed,
    Object? infoId = freezed,
    Object? author = freezed,
    Object? viewNum = freezed,
    Object? favTime = freezed,
    Object? thumbnail = freezed,
    Object? videoUrl = freezed,
  }) {
    return _then(_$_ViewHistory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      infoCid: freezed == infoCid
          ? _value.infoCid
          : infoCid // ignore: cast_nullable_to_non_nullable
              as int?,
      infoId: freezed == infoId
          ? _value.infoId
          : infoId // ignore: cast_nullable_to_non_nullable
              as int?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      viewNum: freezed == viewNum
          ? _value.viewNum
          : viewNum // ignore: cast_nullable_to_non_nullable
              as int?,
      favTime: freezed == favTime
          ? _value.favTime
          : favTime // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ViewHistory with DiagnosticableTreeMixin implements _ViewHistory {
  const _$_ViewHistory(
      {required this.id,
      required this.title,
      this.infoCid,
      this.infoId,
      this.author,
      this.viewNum,
      this.favTime,
      this.thumbnail,
      this.videoUrl});

  factory _$_ViewHistory.fromJson(Map<String, dynamic> json) =>
      _$$_ViewHistoryFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final int? infoCid;
  @override
  final int? infoId;
  @override
  final String? author;
  @override
  final int? viewNum;
  @override
  final String? favTime;
  @override
  final String? thumbnail;
  @override
  final String? videoUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ViewHistory(id: $id, title: $title, infoCid: $infoCid, infoId: $infoId, author: $author, viewNum: $viewNum, favTime: $favTime, thumbnail: $thumbnail, videoUrl: $videoUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ViewHistory'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('infoCid', infoCid))
      ..add(DiagnosticsProperty('infoId', infoId))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('viewNum', viewNum))
      ..add(DiagnosticsProperty('favTime', favTime))
      ..add(DiagnosticsProperty('thumbnail', thumbnail))
      ..add(DiagnosticsProperty('videoUrl', videoUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ViewHistory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.infoCid, infoCid) || other.infoCid == infoCid) &&
            (identical(other.infoId, infoId) || other.infoId == infoId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.viewNum, viewNum) || other.viewNum == viewNum) &&
            (identical(other.favTime, favTime) || other.favTime == favTime) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, infoCid, infoId,
      author, viewNum, favTime, thumbnail, videoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ViewHistoryCopyWith<_$_ViewHistory> get copyWith =>
      __$$_ViewHistoryCopyWithImpl<_$_ViewHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ViewHistoryToJson(
      this,
    );
  }
}

abstract class _ViewHistory implements ViewHistory {
  const factory _ViewHistory(
      {required final String id,
      required final String title,
      final int? infoCid,
      final int? infoId,
      final String? author,
      final int? viewNum,
      final String? favTime,
      final String? thumbnail,
      final String? videoUrl}) = _$_ViewHistory;

  factory _ViewHistory.fromJson(Map<String, dynamic> json) =
      _$_ViewHistory.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int? get infoCid;
  @override
  int? get infoId;
  @override
  String? get author;
  @override
  int? get viewNum;
  @override
  String? get favTime;
  @override
  String? get thumbnail;
  @override
  String? get videoUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ViewHistoryCopyWith<_$_ViewHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
