/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'application.dart';

class Download {
  final String? downPath;
  final DownloadCallback? callback;

  Download({this.downPath = '', this.callback}) {
    bindBackgroundIsolate(callback);
  }

  String? curTaskId = '';
  final ReceivePort _port = ReceivePort();

  bindBackgroundIsolate(DownloadCallback? callback) async {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate(callback);
      return;
    }
    _port.listen((dynamic data) {
      // print('下载中心监听  UI Isolate Callback: $data');
      callback?.call(data[0], data[1], data[2]);
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  ///下载回调
  ///
  ///你的UI在主隔离中呈现，而下载事件来自于后台隔离(换句话说，回调代码在后台隔离中运行)，所以你必须处理两个隔离之间的通信
  static downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  //检查权限
  Future<bool> _checkPermission() async {
    Permission permission = Permission.storage;
    PermissionStatus status = await permission.request();
    // print('检测权限$status');
    if (status.isGranted) {
      //权限通过
      return true;
    } else if (status.isDenied) {
      //权限拒绝， 需要区分IOS和Android，二者不一样
      return false;
    } else if (status.isPermanentlyDenied) {
      //权限永久拒绝，且不在提示，需要进入设置界面，IOS和Android不同
      BotToast.showSimpleNotification(title: '需要您的存储授权才能继续下载');
      await Future.delayed(Duration(seconds: 2));
      openAppSettings();
    } else if (status.isRestricted) {
      //权限永久拒绝，且不在提示，需要进入设置界面，IOS和Android不同
      BotToast.showSimpleNotification(title: '您的活动受限制（家长/控件');
      await Future.delayed(Duration(seconds: 2));
      openAppSettings();
    }
    return false;
  }

  Future<String?> findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    } else if (Platform.isIOS) {
      externalStorageDirPath = Application.documentDir.absolute.path;
    }
    //验证目录是否存在
    String localPath =
        externalStorageDirPath! + Platform.pathSeparator + downPath!;
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }

    return localPath;
  }

  //通过taskId打开文件
  Future<bool> openDownloadedFile(String? taskId) async {
    if (taskId != null) {
      bool opened = await FlutterDownloader.open(taskId: taskId);
      if (!opened) {
        BotToast.showText(text: '您手机未安装可以打开此文件的应用');
      }

      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  //open 是否在已经下载完成的情况下打开
  Future<String?> startDownload(
      {required String link, bool open = true}) async {
    bool isStorage = await _checkPermission();
    if (!isStorage) {
      return null;
    }

    final tasks = await FlutterDownloader.loadTasks();

    String? nowTaskid;
    if (tasks != null && tasks.isNotEmpty) {
      bool hasExisted = tasks.any((DownloadTask downloadTask) {
        nowTaskid = downloadTask.taskId;
        return downloadTask.url == link &&
            downloadTask.status == DownloadTaskStatus.complete;
      });
      if (hasExisted && nowTaskid != null) {
        if (open) {
          openDownloadedFile(nowTaskid);
        }
        return nowTaskid;
      }
    }

    curTaskId = await FlutterDownloader.enqueue(
      url: link,
      savedDir: (await findLocalPath())!,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
    return curTaskId;
  }

  //获取所有任务
  Future<List<DownloadTask>?> getAllLoadTasks() async {
    return FlutterDownloader.loadTasks();
  }

  void cancelDownload(String? taskId) async {
    await FlutterDownloader.cancel(taskId: taskId!);
  }

  void pauseDownload(String? taskId) async {
    await FlutterDownloader.pause(taskId: taskId!);
  }

  void resumeDownload(String? taskId) async {
    String? newTaskId = await FlutterDownloader.resume(taskId: taskId!);
    curTaskId = newTaskId;
  }

  void retryDownload(String? taskId) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: taskId!);
    curTaskId = newTaskId;
  }

  void delete(String? taskId) async {
    await FlutterDownloader.remove(taskId: taskId!, shouldDeleteContent: true);
    /* await _prepare();
    setState(() {});*/
  }
}
