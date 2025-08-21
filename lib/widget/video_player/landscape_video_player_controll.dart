/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

//控件
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';

// import 'package:wakelock/wakelock.dart';

import '../video_player/center_play_button.dart';
import '../video_player/video_player_layout.dart';
import '../video_player/video_player_model.dart';

class LandscapeVideoPlayerControll extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final VideoPlayerModel videoPlayerModel;

  const LandscapeVideoPlayerControll({
    super.key,
    required this.videoPlayerController,
    required this.videoPlayerModel,
  });

  @override
  State<LandscapeVideoPlayerControll> createState() =>
      _LandscapeVideoPlayerControllState();
}

class _LandscapeVideoPlayerControllState extends State<LandscapeVideoPlayerControll> {
  VideoPlayerController get _controller => widget.videoPlayerController;

  VideoPlayerModel get _videoPlayerModel => widget.videoPlayerModel;
  late Timer? isPressTimer;
  bool isPress = false;
  late Duration totalDuration; //当前播放视频的总时长
  late Duration currentDuration; //当前播放视频的位置
  String tDuration = "0:00:00";
  String cDuration = "0:00:00";
  late Offset startPosition; // 起始位置
  late double movePan; // 偏移量累计总和
  late double layoutWidth; // 组件宽度
  late double layoutHeight; // 组件高度
  bool allowHorizontal = false; // 是否允许快进
  Duration position = const Duration(seconds: 0); // 当前时间
  double brightness = 0.0; //亮度
  bool brightnessOk = false; // 是否允许调节亮度
  bool showSettingDialog = false; //是否显示进度数据
  String showTip = ''; //声音亮度进度等提示信息
  late double _bottomVl; //进度条动画距离
  bool clickProgress = false;

  @override
  void initState() {
    _controller.addListener(_videoListener);
    isPressTimer = Timer(const Duration(), () {});
    _bottomVl = -100.w;
    _initDuration();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    isPressTimer?.cancel();
    isPressTimer = null;
    super.dispose();
  }

  //原生播放器监听
  void _videoListener() {
    _initDuration();
    setState(() {});
  }

  void _initDuration() {
    if (!mounted) return;
    totalDuration = _controller.value.duration;
    currentDuration = _controller.value.position;
    tDuration = totalDuration.toString().substring(0, 7);
    cDuration = currentDuration.toString().substring(0, 7);
  }

  Widget _buildFullScreenVideo() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: VideoPlayerLayout(
          videoPlayerController: _controller,
          fit: BoxFit.fitHeight,
          control: LandscapeVideoPlayerControll(
            videoPlayerController: _controller,
            videoPlayerModel: _videoPlayerModel,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _pushFullScreenWidget(BuildContext context) async {
    final TransitionRoute<void> route =
        MaterialPageRoute(fullscreenDialog: true,builder: (context) => _buildFullScreenVideo());
    onEnterFullScreen();
    // Wakelock.enable();
    await Navigator.of(context).push(route);
    _videoPlayerModel.exitFullScreen();
    // The wakelock plugins checks whether it needs to perform an action internally,
    // so we do not need to check Wakelock.isEnabled.
    // Wakelock.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void onEnterFullScreen() {
    final videoWidth = _controller.value.size.width;
    final videoHeight = _controller.value.size.height;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    final isLandscapeVideo = videoWidth > videoHeight;
    final isPortraitVideo = videoWidth < videoHeight;

    /// Default behavior
    /// Video w > h means we force landscape
    if (isLandscapeVideo) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    /// Video h > w means we force portrait
    else if (isPortraitVideo) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    /// Otherwise if h == w (square video)
    else {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }

  //重置上次拖动进度
  void _resetPlayProgress(BuildContext context) {
    startPosition = const Offset(0, 0);
    movePan = 0;
    layoutHeight = context.size!.height;
    layoutWidth = context.size!.width;
  }

  void _onVerticalDragStart(details) async {
    _resetPlayProgress(context);
    startPosition = details.globalPosition;
    if (startPosition.dx < (layoutWidth / 2)) {
      /// 左边触摸
      // brightness = await Screen.brightness;
      try {
        brightness = await ScreenBrightness().current;
      } catch (e) {
        debugPrint('brightness catch:Failed to get current brightness');
      }
      brightnessOk = true;
    }
  }

  void _onVerticalDragUpdate(details) {
    // print('--');
    // var matrix = widget.transformationController!.value.clone();
    // matrix.translate(-5.0);
    // widget.transformationController?.value = matrix;
    /// 累计计算偏移量(下滑减少百分比，上滑增加百分比)
    movePan += (-details.delta.dy);
    /*print(
        "偏移量/整体高度${movePan.toString()}${(movePan / layoutHeight).toString()}");*/
    if (startPosition.dx < (layoutWidth / 2)) {
      /// 左边触摸
      if (brightnessOk = true) {
        setState(() {
          showTip = '亮度：${(_setBrightnessValue() * 100).toInt()}%';
          showSettingDialog = true;
        });
      }
    } else {
      /// 右边触摸
      setState(() {
        showTip = '音量：${(_setVerticalValue(num: 2) * 100).toInt()}%';
        showSettingDialog = true;
      });
    }
  }

  void _onVerticalDragEnd(_) async {
    if (startPosition.dx < (layoutWidth / 2)) {
      // 左边触摸
      if (brightnessOk) {
        try {
          await ScreenBrightness().setScreenBrightness(_setBrightnessValue());
        } catch (e) {
          debugPrint('brightness catch:Failed to set brightness');
        }
        brightnessOk = true;
      }
    } else {
      // 右边触摸
      await _controller.setVolume(_setVerticalValue());
    }
    setState(() {
      showSettingDialog = false;
    });
  }

  double _setBrightnessValue() {
    // 亮度百分控制
    double value =
        //toStringAsFixed保留两位小数点
        double.parse((movePan / layoutHeight + brightness).toStringAsFixed(2));
    if (value >= 1.00) {
      value = 1.00;
    } else if (value <= 0.00) {
      value = 0.00;
    }
    return value;
  }

  double _setVerticalValue({int num = 1}) {
    // 声音亮度百分控制
    double value = double.parse(
        (movePan / layoutHeight + _controller.value.volume)
            .toStringAsFixed(num));
    if (value >= 1.0) {
      value = 1.0;
    } else if (value <= 0.0) {
      value = 0.0;
    }
    return value;
  }

  void _onHorizontalDragStart(DragStartDetails details) async {
    _resetPlayProgress(context);
    // 获取当前时间
    position = _controller.value.position;
    // 暂停成功后才允许快进手势
    allowHorizontal = true;
    setState(() {
      showSettingDialog = true;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    // 累计计算偏移量
    movePan += details.delta.dx;
    double value = _setHorizontalValue();
    // 用百分比计算出当前的秒数
    int mil = (value * _controller.value.duration.inMilliseconds).toInt();
    String currentSecond = _printDuration(Duration(milliseconds: mil));
    setState(() {
      showTip = "$currentSecond/$tDuration";
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _onHorizontalDragEnd(DragEndDetails details) async {
    if (!allowHorizontal) {
      return;
    }
    double value = _setHorizontalValue();
    int current = (value * _controller.value.duration.inMilliseconds).toInt();
    await _controller.seekTo(Duration(milliseconds: current));
    allowHorizontal = false;
    setState(() {
      showSettingDialog = false;
    });
  }

  double _setHorizontalValue() {
    // 进度条百分控制
    double valueHorizontal =
        double.parse((movePan / layoutWidth).toStringAsFixed(2));
    // 当前进度条百分比
    double currentValue =
        position.inMilliseconds / _controller.value.duration.inMilliseconds;
    double value =
        double.parse((currentValue + valueHorizontal).toStringAsFixed(2));
    /*print(
        "偏移量$movePan,偏移百分比${movePan / layoutWidth},"
            "进度条不知道什么参数${_controller.value.duration.inMilliseconds}"
            "进度条百分比${position.inMilliseconds / _controller.value.duration.inMilliseconds}"
            ",value$value"
    );*/
    if (value >= 1.00) {
      value = 1.00;
    } else if (value <= 0.00) {
      value = 0.00;
    }
    return value;
  }

  Widget buildControls(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.hardEdge,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                setState(() {
                  isPress = !isPress;
                  _bottomVl = isPress ? 10.w : -100.w;
                });
                isPressTimer?.cancel();
                isPressTimer = Timer(
                  const Duration(milliseconds: 5000),
                  () {
                    if (!mounted) return;
                    setState(() {
                      isPress = false;
                    });
                  },
                );
              },
              onVerticalDragStart: _onVerticalDragStart,
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragEnd: _onVerticalDragEnd,
              onHorizontalDragStart: _onHorizontalDragStart,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              onLongPress: () {
                _controller.setPlaybackSpeed(2);
                setState(() {
                  showSettingDialog = true;
                  showTip = "2x加速中..";
                });
              },
              onLongPressUp: () {
                _controller.setPlaybackSpeed(1);
                setState(() {
                  showSettingDialog = false;
                });
              },
              onDoubleTap: () {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              },
              child: SizedBox.expand(),
            ),
            if (showSettingDialog)
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  showTip,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                  // setState(() {});
                },
                child: CenterPlayButton(
                  show: isPress,
                  isPlaying: _controller.value.isPlaying,
                  isFinished: currentDuration == totalDuration,
                  iconColor: Colors.white,
                ),
              ),
            ),
            if (isPress)
              AnimatedPositioned(
                bottom: _bottomVl,
                left: 0,
                right: 0,
                duration: Duration(milliseconds: 200),
                child: SafeArea(
                  bottom: _videoPlayerModel.isFullScreen,
                  child: SizedBox(
                    child: Center(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              "$cDuration/$tDuration",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.w),
                            ),
                          ),
                          Expanded(
                            child: Listener(
                              onPointerHover: (event) {
                                setState(() {
                                  clickProgress = true;
                                });
                              },
                              onPointerUp: (event) {
                                setState(() {
                                  clickProgress = false;
                                });
                              },
                              child: AnimatedContainer(
                                width: 750.w,
                                height: clickProgress ? 30.w : 20.w,
                                margin: EdgeInsets.only(
                                    bottom: clickProgress ? 10.w : 0.w),
                                duration: Duration(seconds: 1),
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: const VideoProgressColors(
                                      backgroundColor: Colors.white24,
                                      bufferedColor: Colors.white,
                                      playedColor: Colors.pinkAccent),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_videoPlayerModel.isFullScreen) {
                                Navigator.of(
                                  context,
                                ).pop();
                                _videoPlayerModel.exitFullScreen();
                              } else {
                                _videoPlayerModel.enterFullScreen();
                                _pushFullScreenWidget(context);
                              }
                            },
                            iconSize: 60.w,
                            splashRadius: 1,
                            icon: Icon(
                              _videoPlayerModel.isFullScreen
                                  ? Icons.fullscreen_exit
                                  : Icons.fullscreen,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_videoPlayerModel.isFullScreen) {
      return buildControls(context);
    } else {
      return SafeArea(
        bottom: false,
        child: buildControls(context),
      );
    }
  }
}
