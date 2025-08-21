/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../model/parameters.dart';
import '../model/video.dart';
import '../provider/view_state_refresh_list_model.dart';

final homeVideoListProvider =
    ChangeNotifierProvider.autoDispose.family<HomeVideoListModel, HomeVideoListParameters>(
  (ref, arg) {
    return HomeVideoListModel(arg.pid,searchKey: arg.searchKey);
  },
);

class HomeVideoListModel extends ViewStateRefreshListModel<Video> {
  final int cid;
  String? searchKey;
  HomeVideoListModel(this.cid,{this.searchKey});

  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    var res = await Api.videoList(cid: cid, pageNum: pageNum,searKey: searchKey);
    try {
      res.data = List.generate(
          res.data.length, (index) => Video.fromJson(res.data[index]));
    } catch (e) {
      res.data = [];
    }
    return res;
  }
}
