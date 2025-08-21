/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../generated/assets.dart';
import '../../utils/icon_fonts.dart';
import '../video_player/video_player_model.dart';

//视频部分暂停,喜欢
class PortraitVideoPlayerLike extends StatefulWidget {
  final VoidCallback? onDoubleClick;
  final VideoPlayerModel videoPlayerModel;

  const PortraitVideoPlayerLike(
      {super.key, this.onDoubleClick, required this.videoPlayerModel});

  @override
  createState() => _PortraitVideoPlayerLikeState();
}

class _PortraitVideoPlayerLikeState extends State<PortraitVideoPlayerLike> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.videoPlayerModel.togglePause();
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                _HeartWidget(onDoubleClick: widget.onDoubleClick),
                if (widget.videoPlayerModel.playStatus == PlayStatus.pause) ...[
                  Center(
                    child: Icon(
                      IconFonts.play,
                      size: 120.w,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        _BottomProgress(
            videoPlayerController:
                widget.videoPlayerModel.videoPlayerController!),
        SizedBox(height: 10.w)
      ],
    );
  }
}

class _HeartWidget extends StatefulWidget {
  final VoidCallback? onDoubleClick;

  const _HeartWidget({this.onDoubleClick});

  @override
  State<_HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<_HeartWidget> {
  List<Offset> iconOffset = [];
  Offset clickPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () {
        setState(() {
          iconOffset.add(clickPosition);
        });
        widget.onDoubleClick?.call();
      },
      onDoubleTapDown: (details) {
        clickPosition = details.localPosition;
      },
      child: Stack(
        children: [
          ...heartWidget(),
        ],
      ),
    );
  }

  List<Widget> heartWidget() {
    return iconOffset
        .map((e) => _TikTokFavoriteAnimationIcon(
              position: e,
              size: 150.w,
              onAnimationComplete: null,
            ))
        .toList();
  }
}

class _BottomProgress extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const _BottomProgress({required this.videoPlayerController});

  @override
  State<_BottomProgress> createState() => _BottomProgressState();
}

class _BottomProgressState extends State<_BottomProgress> {
  VideoPlayerController get videoPlayerController =>
      widget.videoPlayerController;
  bool click = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) {
        setState(() {
          click = true;
        });
      },
      onPointerUp: (event) {
        setState(() {
          click = false;
        });
      },
      child: AnimatedContainer(
        width: 750.w,
        height: click ? 30.w : 20.w,
        margin: EdgeInsets.only(bottom: click ? 10.w : 0.w),
        duration: Duration(seconds: 1),
        child: VideoProgressIndicator(
          videoPlayerController,
          allowScrubbing: true,
          colors: const VideoProgressColors(
              backgroundColor: Colors.white24,
              bufferedColor: Colors.white,
              playedColor: Colors.pinkAccent),
        ),
      ),
    );
  }
}

//心型动画控件
class _TikTokFavoriteAnimationIcon extends StatefulWidget {
  final Offset position;
  final double size;
  final Function? onAnimationComplete;

  const _TikTokFavoriteAnimationIcon({
    required this.position,
    this.onAnimationComplete,
    this.size = 100,
  });

  @override
  createState() => _TikTokFavoriteAnimationIconState();
}

class _TikTokFavoriteAnimationIconState
    extends State<_TikTokFavoriteAnimationIcon> with TickerProviderStateMixin {
  late AnimationController _animationController;

  double rotate = pi / 10.0 * (2 * Random().nextDouble() - 1);

  double appearDuration = 0.1;

  double dismissDuration = 0.8;

  @override
  void initState() {
    _animationController = AnimationController(
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //开始动画
  startAnimation() async {
    await _animationController.forward();
    widget.onAnimationComplete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - widget.size / 2,
      top: widget.position.dy - widget.size,
      child: _getBody(),
    );
  }

  //获取动画的值
  double get value => _animationController.value;

  double get opacity {
    if (value < appearDuration) {
      return 0.9 / appearDuration * value;
    }
    if (value < dismissDuration) {
      return 0.9;
    }
    var res = 0.9 - (value - dismissDuration) / (1 - dismissDuration);
    return res < 0 ? 0 : res;
  }

  double get scale {
    if (value <= 0.5) {
      return 0.6 + value / 0.5 * 0.5;
    } else if (value <= 0.8) {
      return 1.1 * (1 / 1.1 + (1.1 - 1) / 1.1 * (value - 0.8) / 0.25);
    } else {
      return 1 + (value - 0.8) / 0.2 * 0.5;
    }
  }

  _getBody() {
    return Transform.rotate(
      angle: rotate,
      child: Opacity(
        opacity: opacity,
        child: Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: scale,
          child: _getContent(),
        ),
      ),
    );
  }

  _getContent() {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => RadialGradient(
        center: Alignment.topLeft.add(Alignment(0.5, 0.5)),
        colors: const [
          Color(0xffEF6F6F),
          Color(0xffF03E3E),
        ],
      ).createShader(bounds),
      child: Image.asset(
        Assets.imagesRedHeart,
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
