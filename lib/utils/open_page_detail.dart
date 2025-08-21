/*
 * zhijian-flutter版
 * (c) 2021 - 2023 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/video.dart';
import '../model/view_history.dart';
import '../routes/routes.dart';
import 'helper.dart';
import 'history_storage.dart';

class OpenPageDetail{
  static openVideoDetail(BuildContext context,Video video){
    context.pushNamed(Routes.videoDetails.name, extra: video);
    // HistoryStorage(key: 'history').removeAll();
    var fav = ViewHistory(
        id: "video_${video.id}",
        title: video.title,
        thumbnail: video.thumbnail,
        viewNum: video.viewNum,
        favTime: Helper.nowTime(),
        infoId: video.id,
        author: video.user?.username ?? '',
        videoUrl: video.videoUrl ?? '',
    );
    HistoryStorage(key: 'history').setHistory(fav);
  }
}