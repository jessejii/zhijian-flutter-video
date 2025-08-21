/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// code : 200
/// message : "sucess"
/// data : 697516
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_code.freezed.dart';
part 'phone_code.g.dart';

@freezed
class PhoneCode with _$PhoneCode {
  const factory PhoneCode({
    required int code,
    String? message,
  }) = _PhoneCode;

  factory PhoneCode.fromJson(Map<String, Object?> json) =>
      _$PhoneCodeFromJson(json);
}
