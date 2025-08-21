/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

//控制器纵横比
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerLayout extends StatelessWidget {
  final BoxFit? fit;
  final double? aspectRatioWhenLoading;
  final VideoPlayerController videoPlayerController;
  final Widget? control;

  const VideoPlayerLayout({
    super.key,
    this.fit,
    this.aspectRatioWhenLoading = 16 / 9,
    required this.videoPlayerController,
    this.control,
  });

  @override
  Widget build(BuildContext context) {
    double videoHeight = videoPlayerController.value.size.height;
    double videoWidth = videoPlayerController.value.size.width;
    return Stack(
      children: [
        Center(
          child: LayoutBuilder(
            builder: (context, size) {
              double aspectRatio = (size.maxHeight == double.infinity ||
                      size.maxWidth == double.infinity)
                  ? (videoPlayerController.value.isInitialized == true
                      ? videoPlayerController.value.aspectRatio
                      : aspectRatioWhenLoading!)
                  : size.maxWidth / size.maxHeight;
              return AspectRatio(
                aspectRatio: aspectRatio,
                child: FittedBox(
                  fit: realyFit(fit, videoHeight, videoWidth),
                  clipBehavior: Clip.hardEdge,
                  child: videoPlayerController.value.isInitialized == true
                      ? SizedBox(
                          height: videoHeight,
                          width: videoWidth,
                          child: VideoPlayer(videoPlayerController),
                        )
                      : SizedBox.shrink(),
                ),
              );
            },
          ),
        ),
        control != null ? Positioned.fill(child: control!) : SizedBox.shrink()
      ],
    );
  }

  BoxFit realyFit(BoxFit? fit, double videoHeight, double videoWidth) {
    if (fit != null) {
      return fit;
    }
    if (videoWidth > videoHeight) {
      return BoxFit.fitWidth;
    }
    return BoxFit.cover;
  }
}
