/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/video.dart';
import '../widget/portrait_video_player_bottom.dart';
import '../widget/portrait_video_player_right.dart';
import '../widget/video_player/portrait_video_player.dart';

class PortraitVideoWidget extends StatelessWidget {
  final Video video;

  const PortraitVideoWidget({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          PortraitVideoPlayer(
            videoUrl: video.videoUrl,
            id: video.id,
          ),
          Positioned(
            bottom: 100.w,
            right: 0,
            child: PortraitVideoPlayerRight(video: video),
          ),
          Positioned(
            bottom: 50.w,
            left: 0,
            child: PortraitVideoPlayerBottom(author: video.user?.username),
          ),
        ],
      ),
    );
  }
}
