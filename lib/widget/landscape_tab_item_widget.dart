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
import '../viewmodel/home_video_model.dart';
import '../widget/landscape_video_item_widget.dart';

class LandscapeTabItemWidget extends StatefulWidget {
  final int cid;
  final ValueChanged<EasyRefreshController>? onReady;

  const LandscapeTabItemWidget(this.cid, {super.key, this.onReady});

  @override
  createState() => _LandscapeTabItemWidgetState();
}

class _LandscapeTabItemWidgetState extends State<LandscapeTabItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HomeVideoListModel>(
      provider: homeVideoListProvider(HomeVideoListParameters(widget.cid)),
      onModelReady: (model) {
        widget.onReady?.call(model.refreshController);
        model.initData();
      },
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
            itemBuilder: (context, index) => LandscapeVideoItemWidget(
              video: model.list[index]),
            itemCount: model.list.length,
            cacheExtent: 6,
          ),
        );
      },
    );
  }
}
