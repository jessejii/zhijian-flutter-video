import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterPlayButton extends StatelessWidget {
  const CenterPlayButton({
    super.key,
    this.iconColor,
    this.iconSize,
    required this.show,
    required this.isPlaying,
    required this.isFinished,
    this.onPressed,
  });

  final Color? iconColor;
  final double? iconSize;
  final bool show;
  final bool isPlaying;
  final bool isFinished;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return show
        ? AnimatedOpacity(
            opacity: show ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            // Always set the iconSize on the IconButton, not on the Icon itself:
            // https://github.com/flutter/flutter/issues/52980
            child: IconButton(
              iconSize: iconSize ?? 80.w,
              padding: EdgeInsets.zero,
              icon: isFinished
                  ? Icon(Icons.replay, color: iconColor)
                  : _AnimatedPlayPause(
                      color: iconColor,
                      playing: isPlaying,
                      size: iconSize ?? 80.w,
                    ),
              onPressed: onPressed,
            ),
          )
        : SizedBox.shrink();
  }
}

/// A widget that animates implicitly between a play and a pause icon.
class _AnimatedPlayPause extends StatefulWidget {
  const _AnimatedPlayPause({
    required this.playing,
    this.color,
    this.size,
  });
  final double? size;
  final bool playing;
  final Color? color;

  @override
  State<StatefulWidget> createState() => _AnimatedPlayPauseState();
}

class _AnimatedPlayPauseState extends State<_AnimatedPlayPause>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    value: widget.playing ? 1 : 0,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void didUpdateWidget(_AnimatedPlayPause oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.playing != oldWidget.playing) {
      if (widget.playing) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      color: widget.color,
      icon: AnimatedIcons.play_pause,
      progress: animationController,
      size: widget.size,
    );
  }
}
