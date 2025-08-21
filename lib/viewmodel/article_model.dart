/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../model/article.dart';
import '../model/parameters.dart';
import '../provider/view_state_refresh_list_model.dart';

final articleListProvider = ChangeNotifierProvider.autoDispose
    .family<ArticleListModel, ArticleListParameters>(
  (ref, arg) {
    return ArticleListModel(arg.pid, uid: arg.uid);
  },
);

class ArticleListModel extends ViewStateRefreshListModel<Article> {
  int pid;
  int? uid;

  ArticleListModel(this.pid, {this.uid});

  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    var res = await Api.articleList(cid: pid, uid: uid, pageNum: pageNum);
    // print(Article.fromJson(res.data[0]));
    try {
      res.data = List.generate(
          res.data.length, (index) => Article.fromJson(res.data[index]));
    } catch (e) {
      res.data = [];
    }

    return res;
  }
}

