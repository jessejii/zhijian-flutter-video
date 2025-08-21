/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:async';

import 'package:flutter/material.dart';

class TimeDownNum extends StatefulWidget {
  final int countdownTime;
  final int perTime;

  final VoidCallback onStop;
  final Function(BuildContext context, int count) build;

  const TimeDownNum(
      {super.key,
      required this.countdownTime,
      required this.perTime,
      required this.onStop,
      required this.build});

  @override
  createState() => _TimeDownNumState();
}

class _TimeDownNumState extends State<TimeDownNum> {
  Timer? _timer;
  late int showDownTime;

  @override
  void initState() {
    showDownTime = widget.countdownTime;
    start();
    super.initState();
  }

  start() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: widget.perTime), (timer) {
      if (showDownTime <= 0) {
        widget.onStop.call();
        _timer?.cancel();
      } else {
        setState(() {
          showDownTime -= widget.perTime;
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context, showDownTime);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
