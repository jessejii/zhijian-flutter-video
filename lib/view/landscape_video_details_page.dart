/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../model/parameters.dart';
import '../model/video.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../utils/application.dart';
import '../utils/config.dart';
import '../utils/helper.dart';
import '../viewmodel/video_model.dart';
import '../widget/author_sub_widget.dart';
import '../widget/video_comment_widget.dart';
import '../widget/video_player_portrait_widget.dart';
import '../widget/video_recommend_list_item_widget.dart';

class LandscapeVideoDetailsPage extends StatefulWidget {
  final Object? extra;

  const LandscapeVideoDetailsPage({super.key, required this.extra});

  @override
  createState() => _LandscapeVideoDetailsPageState();
}

class _LandscapeVideoDetailsPageState extends State<LandscapeVideoDetailsPage>
    with SingleTickerProviderStateMixin {
  Video get data => widget.extra as Video;

  @override
  void initState() {
    WakelockPlus.enable();
    super.initState();
  }
  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1334.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _VideoView(video: data),
              Expanded(child: _VideoRecommentView(video: data))
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoView extends StatelessWidget {
  final Video video;

  const _VideoView({required this.video});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: 750.w, child: VideoPlayerPortraitWidget(video: video)),
        Positioned(
          left: 0,
          top: 0,
          child: SizedBox(
            height: 60.w,
            child: Row(
              children: [
                IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 45.w),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _VideoRecommentView extends StatefulWidget {
  final Video video;

  const _VideoRecommentView({required this.video});

  @override
  createState() => _VideoRecommentViewState();
}

class _VideoRecommentViewState extends State<_VideoRecommentView> {
  Video get video => widget.video;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoRefreshListModel>(
      provider: videoRefreshListProvider(VideoRefreshListParameters(3)),
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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _smallText()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (content, index) {
                    return VideoRecommendListItemWidget(
                        video: model.list[index], replace: true);
                  },
                  childCount: model.list.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _smallText() {
    return Column(
      children: [
        SizedBox(height: 10.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.centerLeft,
          child: Text(
            video.title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        _DetailsWidget(video: video),
        AuthorSubWidget(user: video.user),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8),
          child: Text(
            '推荐',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _DetailsWidget extends StatefulWidget {
  final Video video;

  const _DetailsWidget({required this.video});

  @override
  createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<_DetailsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _heightFactor;

  Video get video => widget.video;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = Tween(begin: .0, end: 0.5).animate(_controller);
    _heightFactor = CurveTween(curve: Curves.easeIn).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _controller.isCompleted
          ? _controller.reverse()
          : _controller.forward(),
      child: Column(
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 30.w,
            ),
            child: Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Share.share(Config.BASE_URL, subject: video.title);
                      },
                      icon: Icon(
                        Icons.share,
                        color: Theme.of(context).hintColor,
                      ),
                      label: Text('分享'),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          builder: (context) => VideoCommentWidget(video: video),
                        );
                      },
                      icon: Icon(
                        Icons.comment_bank_outlined,
                        color: Theme.of(context).hintColor,
                      ),
                      label: Text('评论'),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text('详情'),
                    RotationTransition(
                      turns: _animation,
                      child: Icon(Icons.keyboard_arrow_down,
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
                SizedBox(width: 5.w)
              ],
            ),
          ),
          ClipRect(
            child: AnimatedBuilder(
              animation: _heightFactor,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.centerLeft,
                  heightFactor: _heightFactor.value,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Helper.emptyValue(video.from)
                                ? SizedBox.shrink()
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "来源:",
                                        style: TextStyle(
                                          fontSize: 24.w,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      Text(
                                        "${video.from}",
                                        style: TextStyle(
                                          fontSize: 24.w,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(width: 10.w),
                            Helper.emptyValue(video.author)
                                ? SizedBox.shrink()
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "作者:",
                                        style: TextStyle(
                                          fontSize: 24.w,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      Text(
                                        "${video.author}",
                                        style: TextStyle(
                                          fontSize: 24.w,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        Text(''''''),
                        Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(Routes.setting.name);
                              },
                              child: Text(
                                '投诉/举报',
                                style: TextStyle(
                                    fontSize: 24.w,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
