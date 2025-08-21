/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import './video_player_model.dart';
import '../../generated/assets.dart';
import '../../provider/provider_widget.dart';
import '../video_player/portrait_video_player_like.dart';
import '../video_player/video_player_layout.dart';

class PortraitVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final int id;
  final BoxFit? fit;

  const PortraitVideoPlayer(
      {super.key, required this.videoUrl, required this.id, this.fit});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoPlayerModel>(
        provider: videoPlayerProvider(videoUrl),
        onModelReady: (model) => model.initializePlayer(),
        builder: (context, model, ref, child) {
          if (model.isBusy) {
            return Center(
              child: Image.asset(
                Assets.imagesLoadingBg,
                width: 114.w,
                height: 29.w,
              ),
            );
          }
          if (model.isError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline,
                      size: 80.w, color: Theme.of(context).colorScheme.error),
                  Text(
                    "网络错误",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            );
          }

          //初始化完成
          return VisibilityDetector(
            key: ValueKey(id),
            onVisibilityChanged: (VisibilityInfo visibilityInfo) {
              var visiblePercentage = visibilityInfo.visibleFraction * 100;
              visiblePercentage < 80 ? model.pause() : model.play();
            },
            child: VideoPlayerLayout(
              videoPlayerController: model.videoPlayerController!,
              fit: fit,
              control: PortraitVideoPlayerLike(
                onDoubleClick: () {},
                videoPlayerModel: model,
              ),
            ),
          );
        });
  }
}
