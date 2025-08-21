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
import '../viewmodel/comment_model.dart';
import '../widget/comment_list_item_widget.dart';

class CommentListWidget extends StatefulWidget {
  final int infoId;
  final String infoControl;

  const CommentListWidget(
      {super.key, required this.infoId, required this.infoControl});

  @override
  createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CommentModel>(
      provider:
          commentProvider(CommentParameters(widget.infoId, widget.infoControl)),
      onModelReady: (model) => model.initData(),
      builder: (context, model, ref, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        }
        if (model.isEmpty) {
          return ViewStateEmptyWidget();
        }
        return EasyRefresh(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoad: model.loadMore,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: model.list.length,
            itemBuilder: (context, index) =>
                CommentListItemWidget(comment: model.list[index]),
          ),
        );
      },
    );
  }
}
