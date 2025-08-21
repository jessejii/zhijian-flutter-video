/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/app_update.dart';
import '../utils/config.dart';
import '../utils/download.dart';
import '../utils/helper.dart';

class UpdatePop extends StatefulWidget {
  const UpdatePop({super.key, required this.canPop, required this.appUpdate});

  final bool canPop;
  final AppUpdate appUpdate;

  @override
  createState() => _UpdatePopState();
}

class _UpdatePopState extends State<UpdatePop> {
  double _progress = 0;
  String? nowDownid = '';
  bool downError = false;
  late Download _downLoad;

  @override
  void initState() {
    _downLoad = Download(
      downPath: 'update',
      callback: (id, status, progress) async {
        final navigator = Navigator.of(context);
        //只针对当前下载
        if (id == nowDownid) {
          setState(() {
            _progress = progress / 100;
          });
          if (status == DownloadTaskStatus.failed) {
            setState(() {
              downError = true;
            });
            return;
          }
          if (status == DownloadTaskStatus.complete) {
            await Future.delayed(Duration(seconds: 1));
            await _downLoad.openDownloadedFile(id);
            // if(!mounted) return;
            navigator.pop();
          }
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _downLoad.unbindBackgroundIsolate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: !widget.canPop ? () async => false : null,
      child: AlertDialog(
        title: Text(
          "您的APP版本需要升级",
          style: TextStyle(fontSize: 34.w),
        ),
        content: _alertContent(),
        actions: <Widget>[
          widget.canPop
              ? TextButton(
                  child: Text("返回"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : Text(''),
          TextButton(
            child: downError ? Text('网页下载') : Text("升级"),
            onPressed: () async {
              final Uri toLaunch =
                  Uri(scheme: 'https', host: Config.WEB_URL, path: '/');
              if (downError) {
                if (await canLaunchUrl(toLaunch)) {
                  await launchUrl(toLaunch);
                }
                return;
              }

              if (Platform.isAndroid) {
                nowDownid = await _downLoad.startDownload(
                  link: widget.appUpdate.appUrl,
                  // link: "https://www.jb51.cc/qrcode.jpg?s=12311111",
                  open: true,
                );
              } else if (Platform.isIOS) {
                Helper.openStore();
                return;
              }
            },
          ),
        ],
      ),
    );
  }

  _alertContent() {
    if (downError) {
      return Text(
        "下载出错,您可以以下按钮,从网页下载",
        style: TextStyle(
          color: Colors.green,
          fontSize: 30.w,
        ),
      );
    } else {
      return _progress != 0
          ? LinearProgressIndicator(
              backgroundColor: Theme.of(context).dividerColor,
              valueColor: AlwaysStoppedAnimation(Theme.of(context).hintColor),
              value: _progress,
            )
          : Container(height: double.minPositive);
    }
  }
}
