// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeVideoListParameters {
  int get pid => throw _privateConstructorUsedError;
  String? get searchKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeVideoListParametersCopyWith<HomeVideoListParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeVideoListParametersCopyWith<$Res> {
  factory $HomeVideoListParametersCopyWith(HomeVideoListParameters value,
          $Res Function(HomeVideoListParameters) then) =
      _$HomeVideoListParametersCopyWithImpl<$Res, HomeVideoListParameters>;
  @useResult
  $Res call({int pid, String? searchKey});
}

/// @nodoc
class _$HomeVideoListParametersCopyWithImpl<$Res,
        $Val extends HomeVideoListParameters>
    implements $HomeVideoListParametersCopyWith<$Res> {
  _$HomeVideoListParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? searchKey = freezed,
  }) {
    return _then(_value.copyWith(
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      searchKey: freezed == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeVideoListParametersCopyWith<$Res>
    implements $HomeVideoListParametersCopyWith<$Res> {
  factory _$$_HomeVideoListParametersCopyWith(_$_HomeVideoListParameters value,
          $Res Function(_$_HomeVideoListParameters) then) =
      __$$_HomeVideoListParametersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pid, String? searchKey});
}

/// @nodoc
class __$$_HomeVideoListParametersCopyWithImpl<$Res>
    extends _$HomeVideoListParametersCopyWithImpl<$Res,
        _$_HomeVideoListParameters>
    implements _$$_HomeVideoListParametersCopyWith<$Res> {
  __$$_HomeVideoListParametersCopyWithImpl(_$_HomeVideoListParameters _value,
      $Res Function(_$_HomeVideoListParameters) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? searchKey = freezed,
  }) {
    return _then(_$_HomeVideoListParameters(
      null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      searchKey: freezed == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_HomeVideoListParameters
    with DiagnosticableTreeMixin
    implements _HomeVideoListParameters {
  const _$_HomeVideoListParameters(this.pid, {this.searchKey});

  @override
  final int pid;
  @override
  final String? searchKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeVideoListParameters(pid: $pid, searchKey: $searchKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeVideoListParameters'))
      ..add(DiagnosticsProperty('pid', pid))
      ..add(DiagnosticsProperty('searchKey', searchKey));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeVideoListParameters &&
            (identical(other.pid, pid) || other.pid == pid) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pid, searchKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeVideoListParametersCopyWith<_$_HomeVideoListParameters>
      get copyWith =>
          __$$_HomeVideoListParametersCopyWithImpl<_$_HomeVideoListParameters>(
              this, _$identity);
}

abstract class _HomeVideoListParameters implements HomeVideoListParameters {
  const factory _HomeVideoListParameters(final int pid,
      {final String? searchKey}) = _$_HomeVideoListParameters;

  @override
  int get pid;
  @override
  String? get searchKey;
  @override
  @JsonKey(ignore: true)
  _$$_HomeVideoListParametersCopyWith<_$_HomeVideoListParameters>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ArticleListParameters {
  int get pid => throw _privateConstructorUsedError;
  int? get uid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArticleListParametersCopyWith<ArticleListParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleListParametersCopyWith<$Res> {
  factory $ArticleListParametersCopyWith(ArticleListParameters value,
          $Res Function(ArticleListParameters) then) =
      _$ArticleListParametersCopyWithImpl<$Res, ArticleListParameters>;
  @useResult
  $Res call({int pid, int? uid});
}

/// @nodoc
class _$ArticleListParametersCopyWithImpl<$Res,
        $Val extends ArticleListParameters>
    implements $ArticleListParametersCopyWith<$Res> {
  _$ArticleListParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ArticleListParametersCopyWith<$Res>
    implements $ArticleListParametersCopyWith<$Res> {
  factory _$$_ArticleListParametersCopyWith(_$_ArticleListParameters value,
          $Res Function(_$_ArticleListParameters) then) =
      __$$_ArticleListParametersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pid, int? uid});
}

/// @nodoc
class __$$_ArticleListParametersCopyWithImpl<$Res>
    extends _$ArticleListParametersCopyWithImpl<$Res, _$_ArticleListParameters>
    implements _$$_ArticleListParametersCopyWith<$Res> {
  __$$_ArticleListParametersCopyWithImpl(_$_ArticleListParameters _value,
      $Res Function(_$_ArticleListParameters) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? uid = freezed,
  }) {
    return _then(_$_ArticleListParameters(
      null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_ArticleListParameters
    with DiagnosticableTreeMixin
    implements _ArticleListParameters {
  const _$_ArticleListParameters(this.pid, {this.uid});

  @override
  final int pid;
  @override
  final int? uid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ArticleListParameters(pid: $pid, uid: $uid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ArticleListParameters'))
      ..add(DiagnosticsProperty('pid', pid))
      ..add(DiagnosticsProperty('uid', uid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArticleListParameters &&
            (identical(other.pid, pid) || other.pid == pid) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pid, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArticleListParametersCopyWith<_$_ArticleListParameters> get copyWith =>
      __$$_ArticleListParametersCopyWithImpl<_$_ArticleListParameters>(
          this, _$identity);
}

abstract class _ArticleListParameters implements ArticleListParameters {
  const factory _ArticleListParameters(final int pid, {final int? uid}) =
      _$_ArticleListParameters;

  @override
  int get pid;
  @override
  int? get uid;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleListParametersCopyWith<_$_ArticleListParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CommentParameters {
  int get infoId => throw _privateConstructorUsedError;
  String get infoControl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentParametersCopyWith<CommentParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentParametersCopyWith<$Res> {
  factory $CommentParametersCopyWith(
          CommentParameters value, $Res Function(CommentParameters) then) =
      _$CommentParametersCopyWithImpl<$Res, CommentParameters>;
  @useResult
  $Res call({int infoId, String infoControl});
}

/// @nodoc
class _$CommentParametersCopyWithImpl<$Res, $Val extends CommentParameters>
    implements $CommentParametersCopyWith<$Res> {
  _$CommentParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? infoId = null,
    Object? infoControl = null,
  }) {
    return _then(_value.copyWith(
      infoId: null == infoId
          ? _value.infoId
          : infoId // ignore: cast_nullable_to_non_nullable
              as int,
      infoControl: null == infoControl
          ? _value.infoControl
          : infoControl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommentParametersCopyWith<$Res>
    implements $CommentParametersCopyWith<$Res> {
  factory _$$_CommentParametersCopyWith(_$_CommentParameters value,
          $Res Function(_$_CommentParameters) then) =
      __$$_CommentParametersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int infoId, String infoControl});
}

/// @nodoc
class __$$_CommentParametersCopyWithImpl<$Res>
    extends _$CommentParametersCopyWithImpl<$Res, _$_CommentParameters>
    implements _$$_CommentParametersCopyWith<$Res> {
  __$$_CommentParametersCopyWithImpl(
      _$_CommentParameters _value, $Res Function(_$_CommentParameters) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? infoId = null,
    Object? infoControl = null,
  }) {
    return _then(_$_CommentParameters(
      null == infoId
          ? _value.infoId
          : infoId // ignore: cast_nullable_to_non_nullable
              as int,
      null == infoControl
          ? _value.infoControl
          : infoControl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CommentParameters
    with DiagnosticableTreeMixin
    implements _CommentParameters {
  const _$_CommentParameters(this.infoId, this.infoControl);

  @override
  final int infoId;
  @override
  final String infoControl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CommentParameters(infoId: $infoId, infoControl: $infoControl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CommentParameters'))
      ..add(DiagnosticsProperty('infoId', infoId))
      ..add(DiagnosticsProperty('infoControl', infoControl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentParameters &&
            (identical(other.infoId, infoId) || other.infoId == infoId) &&
            (identical(other.infoControl, infoControl) ||
                other.infoControl == infoControl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, infoId, infoControl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentParametersCopyWith<_$_CommentParameters> get copyWith =>
      __$$_CommentParametersCopyWithImpl<_$_CommentParameters>(
          this, _$identity);
}

abstract class _CommentParameters implements CommentParameters {
  const factory _CommentParameters(final int infoId, final String infoControl) =
      _$_CommentParameters;

  @override
  int get infoId;
  @override
  String get infoControl;
  @override
  @JsonKey(ignore: true)
  _$$_CommentParametersCopyWith<_$_CommentParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VideoRefreshListParameters {
  int get pid => throw _privateConstructorUsedError;
  int? get uid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VideoRefreshListParametersCopyWith<VideoRefreshListParameters>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoRefreshListParametersCopyWith<$Res> {
  factory $VideoRefreshListParametersCopyWith(VideoRefreshListParameters value,
          $Res Function(VideoRefreshListParameters) then) =
      _$VideoRefreshListParametersCopyWithImpl<$Res,
          VideoRefreshListParameters>;
  @useResult
  $Res call({int pid, int? uid});
}

/// @nodoc
class _$VideoRefreshListParametersCopyWithImpl<$Res,
        $Val extends VideoRefreshListParameters>
    implements $VideoRefreshListParametersCopyWith<$Res> {
  _$VideoRefreshListParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VideoRefreshListParametersCopyWith<$Res>
    implements $VideoRefreshListParametersCopyWith<$Res> {
  factory _$$_VideoRefreshListParametersCopyWith(
          _$_VideoRefreshListParameters value,
          $Res Function(_$_VideoRefreshListParameters) then) =
      __$$_VideoRefreshListParametersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pid, int? uid});
}

/// @nodoc
class __$$_VideoRefreshListParametersCopyWithImpl<$Res>
    extends _$VideoRefreshListParametersCopyWithImpl<$Res,
        _$_VideoRefreshListParameters>
    implements _$$_VideoRefreshListParametersCopyWith<$Res> {
  __$$_VideoRefreshListParametersCopyWithImpl(
      _$_VideoRefreshListParameters _value,
      $Res Function(_$_VideoRefreshListParameters) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? uid = freezed,
  }) {
    return _then(_$_VideoRefreshListParameters(
      null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_VideoRefreshListParameters
    with DiagnosticableTreeMixin
    implements _VideoRefreshListParameters {
  const _$_VideoRefreshListParameters(this.pid, {this.uid});

  @override
  final int pid;
  @override
  final int? uid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoRefreshListParameters(pid: $pid, uid: $uid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoRefreshListParameters'))
      ..add(DiagnosticsProperty('pid', pid))
      ..add(DiagnosticsProperty('uid', uid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoRefreshListParameters &&
            (identical(other.pid, pid) || other.pid == pid) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pid, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoRefreshListParametersCopyWith<_$_VideoRefreshListParameters>
      get copyWith => __$$_VideoRefreshListParametersCopyWithImpl<
          _$_VideoRefreshListParameters>(this, _$identity);
}

abstract class _VideoRefreshListParameters
    implements VideoRefreshListParameters {
  const factory _VideoRefreshListParameters(final int pid, {final int? uid}) =
      _$_VideoRefreshListParameters;

  @override
  int get pid;
  @override
  int? get uid;
  @override
  @JsonKey(ignore: true)
  _$$_VideoRefreshListParametersCopyWith<_$_VideoRefreshListParameters>
      get copyWith => throw _privateConstructorUsedError;
}
