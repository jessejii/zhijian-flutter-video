/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/history_model.dart';

import '../model/view_history.dart';

final searchProvider = ChangeNotifierProvider((ref) => SearchHistoryModel());

class SearchHistoryModel extends HistoryModel {
  SearchHistoryModel():super('search_history');

  String? _searchKey;

  String? get searchKey => _searchKey;

  setSearchKey(String key) {
    _searchKey = key;
    addHistory( ViewHistory(id: key, title: key));

    notifyListeners();
  }
}
