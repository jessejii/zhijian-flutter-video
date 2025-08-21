/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../generated/assets.dart';
import '../model/parameters.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../viewmodel/app_model.dart';
import '../viewmodel/video_model.dart';
import '../widget/portrait_video_widget.dart';

class PortraitVideoPage extends StatefulWidget {
  final AppModel appModel;

  const PortraitVideoPage({super.key, required this.appModel});

  @override
  createState() => _PortraitVideoPageState();
}

class _PortraitVideoPageState extends State<PortraitVideoPage>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _pageController = PageController(keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: VisibilityDetector(
        key: ValueKey('protrait-video-page'),
        onVisibilityChanged: (VisibilityInfo visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          visiblePercentage < 80
              ? WakelockPlus.disable()
              : WakelockPlus.enable();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.black),
          child: ProviderWidget<VideoRefreshListModel>(
            provider: videoRefreshListProvider(VideoRefreshListParameters(12)),
            onModelReady: (model) {
              widget.appModel
                  .setPortraitRefreshController(model.refreshController);
              model.initData();
            },
            builder: (context, VideoRefreshListModel model, ref, child) {
              if (model.isBusy || model.isEmpty) {
                return Center(
                  child: Image.asset(
                    Assets.imagesLoadingBg,
                    width: 114.w,
                    height: 29.w,
                  ),
                );
              }
              if (model.isError) {
                return ViewStateErrorWidget(
                  error: model.viewStateError,
                  onPressed: () => model.initData(),
                );
              }
              return EasyRefresh(
                header: MaterialHeader(),
                onRefresh: model.refresh,
                controller: model.refreshController,
                onLoad: model.loadMore,
                callLoadOverOffset: 50,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: model.list.length,
                  itemBuilder: (context, index) => PortraitVideoWidget(
                    video: model.list[index],
                    key: ValueKey(model.list[index].id),
                  ),
                  // onPageChanged: model.onChange,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
