/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../api/net/http_response.dart';
import '../model/message.dart';
import '../provider/view_state_refresh_list_model.dart';

final messageListProvider = ChangeNotifierProvider((ref) => MessageListModel());

class MessageListModel extends ViewStateRefreshListModel {
  @override
  Future<HttpResponse> loadData({int? pageNum}) async {
    var res = await Api.messageList(pageNum: pageNum);
    try {
      res.data = List.generate(
          res.data.length, (index) => Message.fromJson(res.data[index]));
    } catch (e) {
      res.data = [];
    }
    return res;
  }
}
