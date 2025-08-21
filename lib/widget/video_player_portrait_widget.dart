/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/video.dart';
import '../widget/video_player/landscape_video_player.dart';

class VideoPlayerPortraitWidget extends StatefulWidget {
  final Video video;

  const VideoPlayerPortraitWidget({super.key, required this.video});

  @override
  createState() => _VideoPlayerPortraitWidgetState();
}

class _VideoPlayerPortraitWidgetState
    extends State<VideoPlayerPortraitWidget> {
  Video get video => widget.video;

  @override
  Widget build(BuildContext context) {
    // print('HomeVideoWidget build');
    return Container(
      // width: 750.w,
      height: 450.w,
      color: Colors.black,
      child: LandscapeVideoPlayer(
        id: video.id,
        videoUrl: video.videoUrl,
        autoPlay: true,fit: BoxFit.fitWidth,
      ),
    );
  }
}
