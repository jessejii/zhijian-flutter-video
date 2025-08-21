/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/parameters.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../viewmodel/article_model.dart';
import 'article_item_widget.dart';

class ArticleWidget extends StatefulWidget {
  final int cid;
  final int? uid;
  final ValueChanged<EasyRefreshController>? onReady;

  const ArticleWidget(this.cid, {super.key, this.uid, this.onReady});

  @override
  createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ProviderWidget<ArticleListModel>(
      provider: articleListProvider(
          ArticleListParameters(widget.cid, uid: widget.uid)),
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
          header: PhoenixHeader(
            skyColor: Theme.of(context).colorScheme.primary,
            position: IndicatorPosition.behind,
            safeArea: false,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.list.length,
              itemBuilder: (context, index) =>
                  ArticleItemWidget(model.list[index]),
            ),
          ),
        );
      },
    );
  }
}
