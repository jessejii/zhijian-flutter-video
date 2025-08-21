/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAccountAvatarProvider =
    StateNotifierProvider<UserAccountAvatarModel, String>(
        (ref) => UserAccountAvatarModel());

class UserAccountAvatarModel extends StateNotifier<String> {
  UserAccountAvatarModel() : super('');

  void addAvatar(String avatar) {
    state = avatar;
  }
}
