/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

/// token : ".eyJ1aWQiOjEsImF1ZCI6IiIsImV4cCI6MTYyNzM2NzE4OCwiaWF0IjoxNjI3MjM3NTg4LCJpc3MiOiIiLCJqdGkiOiI5NzA0NzRmNjc5NTMwNzc1OWM1NzljYjMxMDQ3OWE3MyIsIm5iZiI6MTYyNzIzNzU4OCwic3ViIjoiIn0.D45DYkz9frlvL9HYERsg9RsetScECugeM-42wQ5VzI8"
library;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login.freezed.dart';
part 'user_login.g.dart';

@freezed
class UserLogin with _$UserLogin {
  const factory UserLogin({required String token}) = _UserLogin;

  factory UserLogin.fromJson(Map<String, Object?> json) =>
      _$UserLoginFromJson(json);
}
