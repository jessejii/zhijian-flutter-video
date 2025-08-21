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

/*final videoListProvider =
    ChangeNotifierProvider.autoDispose.family<VideoListModel, int>(
  (ref, arg) {
    return VideoListModel(arg);
  },
);
@Deprecated('Use [VideoRefreshListModel]')
class VideoListModel extends ViewStateListModel<Video> {
  VideoListModel(this.cid);

  final int cid;

  // 分页条目数量
  static const int pageSize = 20;

  // 分页第一页页码
  static const int pageNumFirst = 1;
  int curPage = pageNumFirst;
  bool _canLoadMore = true;
  @override
  Future<HttpResponse> loadData() async {
    var res = await Api.videoList(cid: cid, pageNum: curPage);
    try {
      res.data = List.generate(
          res.data.length, (index) => Video.fromJson(res.data[index]));
    } catch (e) {
      res.data = [];
    }
    return res;
  }

  Future<void> onChange(int page) async {
    // debugPrint("${++page}");
    if (++page == list.length) {
      await loadMore();
    }
  }

  /// 加载更多
  Future<void> loadMore() async {
    print('loadmore');
    if (!_canLoadMore) {
      return;
    }
    ++curPage;
    var res = await loadData();
    if (!res.ok) {
      curPage--;
      setError(res.error);
      return;
    }

    List<Video>? data = res.data;
    if (data == null || data.isEmpty) {
      curPage--;
    } else {
      onCompleted(data);
      list.addAll(data);
      if (data.length < pageSize) {
        _canLoadMore = false;
      } //最后一页
      notifyListeners();
    }
  }

  //修改列表数据增加点击
  void editData(int id) {
    for (int i = 0; i < list.length; i++) {
      var data = list[i];
      if (data.id == id) {
        var foo = data.toJson();
        foo['commentNum']++;
        list[i] = Video.fromJson(foo);
        break;
      }
    }
    notifyListeners();
  }
}*/

final videoRefreshListProvider = ChangeNotifierProvider.autoDispose
    .family<VideoRefreshListModel, VideoRefreshListParameters>(
  (ref, arg) {
    return VideoRefreshListModel(arg.pid, uid: arg.uid);
  },
);

class VideoRefreshListModel extends ViewStateRefreshListModel<Video> {
  final int pid;
  final int? uid;

  VideoRefreshListModel(this.pid, {this.uid});

  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    // print("videorefreshmodel:$uid");
    var res = await Api.videoList(cid: pid, uid: uid, pageNum: pageNum);
    // print(res);
    try {
      res.data = List.generate(
          res.data.length, (index) => Video.fromJson(res.data[index]));
    } catch (e) {
      res.data = [];
    }
    return res;
  }
}
