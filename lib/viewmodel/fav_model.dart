/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../model/fav.dart';
import '../model/video.dart';
import '../provider/view_state_model.dart';
import '../provider/view_state_refresh_list_model.dart';

final favListProvider = ChangeNotifierProvider((ref) => FavListModel());

class FavListModel extends ViewStateRefreshListModel<Fav> {
  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    var res = await Api.favList(pageNum: pageNum);
    try {
      res.data = List.generate(
          res.data.length, (index) => Fav.fromJson(res.data[index]));
    } catch (e) {
      // debugPrint("FavListModel:$e");
      res.data = [];
    }
    return res;
  }
}

final favProvider = ChangeNotifierProvider((ref) => FavModel());

class FavModel extends ViewStateModel {
  LinkedHashSet favedData = LinkedHashSet();

  Future getAllFav() async {
    favedData.clear();
    HttpResponse res = await Api.favAll();
    if (!res.ok) {
      return;
    }
    favedData.addAll((res.data as List).toSet());
    setIdle();
  }

  Future<void> favToggle(
      {required BuildContext context,
      required String infoControl,
      required int infoId}) async {
    HttpResponse res =
        await Api.favAddToggle(infoControl: infoControl, infoId: infoId);
    if (!res.ok) {
      setError(res.error);
      return;
    }
    if (res.data == 1) {
      favedData.add(infoId);
    } else {
      favedData.remove(infoId);
    }
    setIdle();
  }

  bool contains(int id) {
    return favedData.contains(id);
  }
}

final favShowListProvider = ChangeNotifierProvider((ref) => FavShowListModel());

//收藏夹中的视频展示
class FavShowListModel extends ViewStateRefreshListModel<Video> {

  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    var res = await Api.favList(pageNum: pageNum);
    try {
      res.data = List.generate(res.data.length,
          (index) => Video.fromJson(res.data[index]['videoInfo']));
    } catch (e) {
      res.data = [];
    }
    return res;
  }
}
