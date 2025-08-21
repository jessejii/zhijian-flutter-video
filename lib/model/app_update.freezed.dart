// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUpdate _$AppUpdateFromJson(Map<String, dynamic> json) {
  return _AppUpdate.fromJson(json);
}

/// @nodoc
mixin _$AppUpdate {
  String get appVersion => throw _privateConstructorUsedError;
  String get appUrl => throw _privateConstructorUsedError;
  int get appMust => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUpdateCopyWith<AppUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUpdateCopyWith<$Res> {
  factory $AppUpdateCopyWith(AppUpdate value, $Res Function(AppUpdate) then) =
      _$AppUpdateCopyWithImpl<$Res, AppUpdate>;
  @useResult
  $Res call({String appVersion, String appUrl, int appMust});
}

/// @nodoc
class _$AppUpdateCopyWithImpl<$Res, $Val extends AppUpdate>
    implements $AppUpdateCopyWith<$Res> {
  _$AppUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appVersion = null,
    Object? appUrl = null,
    Object? appMust = null,
  }) {
    return _then(_value.copyWith(
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      appUrl: null == appUrl
          ? _value.appUrl
          : appUrl // ignore: cast_nullable_to_non_nullable
              as String,
      appMust: null == appMust
          ? _value.appMust
          : appMust // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppUpdateCopyWith<$Res> implements $AppUpdateCopyWith<$Res> {
  factory _$$_AppUpdateCopyWith(
          _$_AppUpdate value, $Res Function(_$_AppUpdate) then) =
      __$$_AppUpdateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appVersion, String appUrl, int appMust});
}

/// @nodoc
class __$$_AppUpdateCopyWithImpl<$Res>
    extends _$AppUpdateCopyWithImpl<$Res, _$_AppUpdate>
    implements _$$_AppUpdateCopyWith<$Res> {
  __$$_AppUpdateCopyWithImpl(
      _$_AppUpdate _value, $Res Function(_$_AppUpdate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appVersion = null,
    Object? appUrl = null,
    Object? appMust = null,
  }) {
    return _then(_$_AppUpdate(
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      appUrl: null == appUrl
          ? _value.appUrl
          : appUrl // ignore: cast_nullable_to_non_nullable
              as String,
      appMust: null == appMust
          ? _value.appMust
          : appMust // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUpdate with DiagnosticableTreeMixin implements _AppUpdate {
  const _$_AppUpdate(
      {required this.appVersion, required this.appUrl, required this.appMust});

  factory _$_AppUpdate.fromJson(Map<String, dynamic> json) =>
      _$$_AppUpdateFromJson(json);

  @override
  final String appVersion;
  @override
  final String appUrl;
  @override
  final int appMust;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUpdate(appVersion: $appVersion, appUrl: $appUrl, appMust: $appMust)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUpdate'))
      ..add(DiagnosticsProperty('appVersion', appVersion))
      ..add(DiagnosticsProperty('appUrl', appUrl))
      ..add(DiagnosticsProperty('appMust', appMust));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUpdate &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.appUrl, appUrl) || other.appUrl == appUrl) &&
            (identical(other.appMust, appMust) || other.appMust == appMust));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appVersion, appUrl, appMust);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppUpdateCopyWith<_$_AppUpdate> get copyWith =>
      __$$_AppUpdateCopyWithImpl<_$_AppUpdate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUpdateToJson(
      this,
    );
  }
}

abstract class _AppUpdate implements AppUpdate {
  const factory _AppUpdate(
      {required final String appVersion,
      required final String appUrl,
      required final int appMust}) = _$_AppUpdate;

  factory _AppUpdate.fromJson(Map<String, dynamic> json) =
      _$_AppUpdate.fromJson;

  @override
  String get appVersion;
  @override
  String get appUrl;
  @override
  int get appMust;
  @override
  @JsonKey(ignore: true)
  _$$_AppUpdateCopyWith<_$_AppUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}
