/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../model/user.dart';
import '../model/user_login.dart';
import '../provider/view_state_model.dart';
import '../utils/application.dart';
import '../utils/config.dart';

final userProvider = ChangeNotifierProvider((ref) => UserModel());

class UserModel extends ViewStateModel {
  static const String kUser = Config.KUSER;
  User? _user;

  User? get user => _user;

  bool get hasLogin => _user != null;

  UserModel() {
    String? userMap = Application.prefs.get(kUser);
    //防止数据错误程序崩溃
    try {
      if (userMap != null) {
        _user = User.fromJson(json.decode(userMap));
      }
    } catch (e) {
      logout();
    }
  }

  @override
  void onError(ViewStateError? viewStateError) {
    // print('error');
    super.onError(viewStateError);
    if (viewStateError?.isUnauthorized ?? false) {
      logout();
    }
  }

  Future _saveToken(UserLogin user) async {
    await Application.prefs.put(Config.TOKEN_KEY, user.token);
  }

  Future _saveUser(User user) async {
    _user = user;
    if (_user != null) {
      await Application.prefs.put(kUser, json.encode(_user));
    }
  }

  /// 清除持久化的用户数据
  Future logout() async {
    await Application.prefs.delete(Config.KUSER);
    await Application.prefs.delete(Config.TOKEN_KEY);
    _user = null;
    notifyListeners();
  }

  //获取会员信息
  Future<void> getUserInfo({update = false}) async {
    await _userInfo(update: update);
  }

  Future<void> _userInfo({update = false}) async {
    //如果本次登录有保存则不更新
    if (update == false && _user != null) {
      return;
    }
    String? token = Application.prefs.get(Config.TOKEN_KEY);
    if (token == null) {
      return;
    }

    HttpResponse res = await Api.userInfo();

    if (!res.ok) {
      setError(res.error);
      return;
    }

    User user = User.fromJson(res.data);
    await _saveUser(user);

    setIdle();
  }

  Future<bool> login(String phone, String code) async {
    //setBusy();
    HttpResponse res = await Api.login(phone, code);

    if (!res.ok) {
      setError(res.error);
      return false;
    }
    UserLogin user = UserLogin.fromJson(res.data);
    await _saveToken(user);
    await _userInfo(update: true);
    return true;
  }

  Future<bool> getCode(String phone) async {
    var res = await Api.phoneCode(phone);
    if (!res.ok) {
      setError(res.error);
      return false;
    }
    //todo 正式版取消
    // print("${res.data}");
    setIdle();
    return true;
  }

  Future<void> changeUsername(String name) async {
    HttpResponse res = await Api.changeUsername(name);
    if (!res.ok) {
      setError(res.error);
      return;
    }
    await _userInfo(update: true);
  }

  //上传头像
  Future uploadAvatar(String localImagePath) async {
    BotToast.showLoading();
    HttpResponse res = await Api.changeAvatar(localImagePath,
        onSendProgress: (int count, int total) {
      if (total == count) {
        BotToast.closeAllLoading();
      }
    });
    if (!res.ok) {
      setError(res.error);
      return false;
    }
    await _userInfo(update: true);
  }
}

final userPubProvider =
    ChangeNotifierProvider.autoDispose.family<UserPubModel, int>(
  (ref, arg) {
    return UserPubModel(arg);
  },
);

class UserPubModel extends ViewStateModel {
  User? data;
  final int? uid;

  UserPubModel(this.uid) : super(viewState: ViewState.busy);

  Future<void> initData() async {
    if (uid == null) {
      return;
    }
    HttpResponse res = await Api.userPubInfo(uid);
    // print(res);
    if (!res.ok) {
      setError(res.error);
      return;
    }
    data = User.fromJson(res.data);
    setIdle();
  }
}
