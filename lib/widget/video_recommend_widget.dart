/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../model/parameters.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../viewmodel/video_model.dart';
import '../widget/video_recommend_list_item_widget.dart';

class VideoRecommendWidget extends StatefulWidget {
  final int cid;
  final int? uid;
  final bool replace; //是否直接在本页打开 替换本页

  const VideoRecommendWidget(this.cid,
      {super.key, this.uid, this.replace = false});

  @override
  createState() => _VideoRecommendWidgetState();
}

class _VideoRecommendWidgetState extends State<VideoRecommendWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<VideoRefreshListModel>(
      provider: videoRefreshListProvider(
          VideoRefreshListParameters(widget.cid, uid: widget.uid)),
      onModelReady: (model) => model.initData(),
      builder: (context, model, ref, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        }
        if (model.isError) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        if (model.list.isEmpty) {
          return ViewStateEmptyWidget();
        }
        return EasyRefresh(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoad: model.loadMore,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return VideoRecommendListItemWidget(
                video: model.list[index],
                replace: true,
              );
            },
            itemCount: model.list.length,
          ),
        );
      },
    );
  }
}
