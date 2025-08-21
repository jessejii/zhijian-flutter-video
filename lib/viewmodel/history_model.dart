/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/net/http_response.dart';
import '../model/view_history.dart';
import '../provider/view_state_refresh_list_model.dart';
import '../utils/history_storage.dart';

final historyProvider =
    ChangeNotifierProvider.autoDispose.family<HistoryModel, String>(
  (ref, arg) {
    return HistoryModel(arg);
  },
);

class HistoryModel extends ViewStateRefreshListModel<ViewHistory> {
  HistoryModel(this.hisKey) {
    _historyStorage = HistoryStorage(key: hisKey);
  }

  late HistoryStorage _historyStorage;
  bool? isAllCheck = false; //全选
  List<int> deleteIds = [];

  late final String hisKey;

  bool isChecked(int index) {
    return deleteIds.contains(index);
  }

  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    var res = _historyStorage.getHistory(currentPage: pageNum ?? 1);
    return HttpResponse.success(res);
  }

  Future<void> addHistory(ViewHistory history) async {
    await _historyStorage.setHistory(history);
    await initData();
  }

  Future<void> addHistoryNotNotify(ViewHistory history) async {
    await _historyStorage.setHistory(history);
  }

  void removeAll() async {
    await _historyStorage.removeAll();
    await initData();
  }

  void itemSel(bool? value, int index) {
    if (value == false) {
      deleteIds.remove(index);
    } else {
      deleteIds.add(index);
      //toSet().toList()去除重复元素
      deleteIds = deleteIds.toSet().toList();
    }
    notifyListeners();
  }

  void bottomSel(bool? value) {
    //获取list所有索引
    List<int> indexs = [for (int i = 0; i < list.length; i++) i];
    if (value == true) {
      deleteIds.addAll(indexs);
    } else {
      //根据提供的数组删除deletedids中的值
      deleteIds.removeWhere((element) => indexs.contains(element));
    }
    isAllCheck = value;
    notifyListeners();
  }

  //根据index获取包含info-id 然后删除
  void delByIds() {
    if (deleteIds.isEmpty) {
      return;
    }
    List<String> delInfoIds = deleteIds.map((e) => list[e].id).toList();
    _historyStorage.removeList(delInfoIds);
    deleteIds.clear();
    initData();
  }
}
