/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import '../api/net/http_response.dart';
import 'view_state_model.dart';

/// 基于
abstract class ViewStateListModel<T> extends ViewStateModel {
  /// 页面数据
  List<T> list = [];

  ViewStateListModel() : super(viewState: ViewState.busy);

  /// 第一次进入页面loading skeleton
  Future<void> initData() async {
    // print('initData');
    //setBusy();
    await refresh(init: true);
  }

  // 下拉刷新
  Future<void> refresh({bool init = false}) async {
    HttpResponse res = await loadData();
    if (!res.ok) {
      if (init) list.clear();
      return;
      // setError(res.error);
    }
    List<T>? data = res.data;
    if (data == null || data.isEmpty) {
      list.clear();
      setEmpty();
    } else {
      onCompleted(data);
      list.clear();
      list.addAll(data);
      setIdle();
    }
  }

  // 加载数据
  Future<HttpResponse> loadData();

  onCompleted(List<T> data) {}
}
