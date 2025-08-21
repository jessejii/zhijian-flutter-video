/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:collection';
import 'dart:convert';

import '../model/view_history.dart';
import '../utils/application.dart';

class HistoryStorage {
  String key;

  HistoryStorage({required this.key});

  Future<void> sotrageSave(String save) async {
    await Application.prefs.put(key, save);
  }

  Future<void> setHistory(ViewHistory history) async {
    List<ViewHistory> saveList = getHistory();
    saveList.insert(0, history);
    // //存储50条超过删除最后一条
    // if (saveList.length > 50) {
    //   saveList.removeLast();
    // }
    LinkedHashSet<ViewHistory> foo = LinkedHashSet();
    foo.addAll(saveList);
    String save = jsonEncode(foo.map((item) => item.toJson()).toList());
    await sotrageSave(save);
  }

  List<ViewHistory> getHistory({int currentPage = 1}) {
    String? storeHistory = Application.prefs.get(key);
    if (storeHistory == null) {
      return [];
    }
    List list = jsonDecode(storeHistory);
    // 每页显示的元素个数
    int pageSize = 20;
    // 根据当前页数和每页显示的元素个数，计算要显示的元素的起始和结束索引
    int startIndex = (currentPage - 1) * pageSize;
    int endIndex = (startIndex + pageSize) > list.length
        ? list.length
        : startIndex + pageSize;
    // 使用 sublist 函数获取要显示的元素列表
    list = list.sublist(startIndex, endIndex);
    List<ViewHistory> re =
        list.map((item) => ViewHistory.fromJson(item)).toList();
    return re;
  }

  Future<void> removeList(List delIds) async {
    if (delIds.isEmpty) return;
    var history = getHistory();
    List<ViewHistory> newHistory =
        history.where((e) => !delIds.contains(e.id)).toList();
    String save = jsonEncode(newHistory.map((e) => e.toJson()).toList());
    await sotrageSave(save);
  }

  removeAll() async {
    // print(key);
    await Application.prefs.delete(key);
  }
}
