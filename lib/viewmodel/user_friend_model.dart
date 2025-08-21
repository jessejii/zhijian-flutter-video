/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../provider/view_state_model.dart';

final userFriendProvider = ChangeNotifierProvider((ref) => UserFriendModel());

class UserFriendModel extends ViewStateModel {
  UserFriendModel() /*:super(viewState:ViewState.busy)*/;

  bool haveSubed = false;

  Future<void> haveSub(int? subUserId) async {
    HttpResponse res = await Api.haveSub(subUserId: subUserId);
    if (!res.ok) {
      return;
    }
    if (res.data == 1) {
      haveSubed = true;
    }
    setIdle();
  }

  Future<void> subToggle(int subUserId) async {
    HttpResponse res = await Api.subdToggle(subUserId: subUserId);

    if (!res.ok) {
      setError(res.error);
      return;
    }
    if (res.data == 1) {
      haveSubed = true;
    } else {
      haveSubed = false;
    }
    setIdle();
  }
}
