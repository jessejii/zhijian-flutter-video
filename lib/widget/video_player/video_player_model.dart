/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../provider/view_state_model.dart';

final videoPlayerProvider =
    ChangeNotifierProvider.autoDispose.family<VideoPlayerModel, String>(
  (ref, arg) {
    return VideoPlayerModel(videoUrl: arg);
  },
);

enum PlayStatus {
  buffering,
  playing,
  pause,
  stop,
  error,
}

class VideoPlayerModel extends ViewStateModel {
  VideoPlayerModel({required this.videoUrl}) : super(viewState: ViewState.busy);

  final String videoUrl;
  VideoPlayerController? videoPlayerController;
  bool _isFullScreen = false;
  PlayStatus _playStatus = PlayStatus.buffering;

  bool get isFullScreen => _isFullScreen;

  PlayStatus get playStatus => _playStatus;

  //手动暂停不参与自动播放
  bool _manuallyPaused = false;

  bool get manuallyPaused => _manuallyPaused;

  @override
  void dispose() {
    videoPlayerController?.dispose();
    videoPlayerController = null;
    super.dispose();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..setLooping(true);
    bool videoError = false;
    await videoPlayerController!
        .initialize()
        .onError<Exception>((error, stackTrace) {
      _playStatus = PlayStatus.error;
      videoError = true;
      setError(error);
    });
    if (videoError) return;
    setIdle();
  }

  @override
  void onError(ViewStateError? viewStateError) {
    debugPrint("play error:$viewStateError}");
  }

  set playStatus(PlayStatus value) {
    _playStatus = value;
    notifyListeners();
  }

  void enterFullScreen() {
    _isFullScreen = true;
  }

  void exitFullScreen() {
    _isFullScreen = false;
  }

  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
  }

  void togglePause() {
    if (_playStatus == PlayStatus.playing) {
      _manuallyPaused = true;
      pause();
    } else {
      _manuallyPaused = false;
      play();
    }
  }

  Future<void> play() async {
    // print(_manuallyPaused);
    if (_manuallyPaused) {
      return;
    }
    bool videoError = false;
    await videoPlayerController?.play().onError((error, stackTrace) {
      _playStatus = PlayStatus.error;
      videoError = true;
      setError();
    });
    if (videoError) return;
    _playStatus = PlayStatus.playing;
    notifyListeners();
  }

  Future<void> pause() async {
    if (_playStatus != PlayStatus.playing) {
      return;
    }
    await videoPlayerController?.pause();
    _playStatus = PlayStatus.pause;
    notifyListeners();
  }

  Future<void> seekTo(Duration moment) async {
    await videoPlayerController?.seekTo(moment);
  }

  Future<void> setVolume(double volume) async {
    await videoPlayerController?.setVolume(volume);
  }
}
