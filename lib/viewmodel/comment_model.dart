/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../model/comment.dart';
import '../model/parameters.dart';
import '../provider/view_state_refresh_list_model.dart';

final commentProvider =
    ChangeNotifierProvider.autoDispose.family<CommentModel, CommentParameters>(
  (ref, arg) {
    return CommentModel(infoId: arg.infoId, infoControl: arg.infoControl);
  },
);

class CommentModel extends ViewStateRefreshListModel<Comment> {
  int totalNum = 0;
  final String infoControl;
  final int infoId;

  CommentModel({required this.infoControl, required this.infoId});

  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    var res = await Api.commentList(
        infoControl: infoControl, infoId: infoId, pageNum: pageNum);
    try {
      res.data = List.generate(
          res.data.length, (index) => Comment.fromJson(res.data[index]));
    } catch (e) {
      res.data = [];
      // debugPrint("comment catch:$e");
    }
    return res;
  }

  Future<bool> addComment({required String content}) async {
    // print("infoId: $infoId,content: $content");
    var res = await Api.commentAdd(
        infoId: infoId, content: content, infoControl: infoControl);
    if (!res.ok) {
      setError(res.error);
      return false;
    }
    refresh();
    return true;
  }
}
