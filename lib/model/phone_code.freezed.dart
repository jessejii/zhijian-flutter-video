// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PhoneCode _$PhoneCodeFromJson(Map<String, dynamic> json) {
  return _PhoneCode.fromJson(json);
}

/// @nodoc
mixin _$PhoneCode {
  int get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhoneCodeCopyWith<PhoneCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneCodeCopyWith<$Res> {
  factory $PhoneCodeCopyWith(PhoneCode value, $Res Function(PhoneCode) then) =
      _$PhoneCodeCopyWithImpl<$Res, PhoneCode>;
  @useResult
  $Res call({int code, String? message});
}

/// @nodoc
class _$PhoneCodeCopyWithImpl<$Res, $Val extends PhoneCode>
    implements $PhoneCodeCopyWith<$Res> {
  _$PhoneCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhoneCodeCopyWith<$Res> implements $PhoneCodeCopyWith<$Res> {
  factory _$$_PhoneCodeCopyWith(
          _$_PhoneCode value, $Res Function(_$_PhoneCode) then) =
      __$$_PhoneCodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String? message});
}

/// @nodoc
class __$$_PhoneCodeCopyWithImpl<$Res>
    extends _$PhoneCodeCopyWithImpl<$Res, _$_PhoneCode>
    implements _$$_PhoneCodeCopyWith<$Res> {
  __$$_PhoneCodeCopyWithImpl(
      _$_PhoneCode _value, $Res Function(_$_PhoneCode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
  }) {
    return _then(_$_PhoneCode(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PhoneCode with DiagnosticableTreeMixin implements _PhoneCode {
  const _$_PhoneCode({required this.code, this.message});

  factory _$_PhoneCode.fromJson(Map<String, dynamic> json) =>
      _$$_PhoneCodeFromJson(json);

  @override
  final int code;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PhoneCode(code: $code, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PhoneCode'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhoneCode &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhoneCodeCopyWith<_$_PhoneCode> get copyWith =>
      __$$_PhoneCodeCopyWithImpl<_$_PhoneCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhoneCodeToJson(
      this,
    );
  }
}

abstract class _PhoneCode implements PhoneCode {
  const factory _PhoneCode({required final int code, final String? message}) =
      _$_PhoneCode;

  factory _PhoneCode.fromJson(Map<String, dynamic> json) =
      _$_PhoneCode.fromJson;

  @override
  int get code;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_PhoneCodeCopyWith<_$_PhoneCode> get copyWith =>
      throw _privateConstructorUsedError;
}
