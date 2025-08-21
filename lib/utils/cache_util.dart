/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';

import '../utils/application.dart';
import '../utils/download.dart';

/// 缓存管理类
class CacheUtil {
  static Directory tempDir = Application.tempDir;
  static final Download _download = Download(downPath: 'update');

  /// 获取缓存大小
  static Future<double> total() async {
    int cacheTotal = await _reduce(tempDir);
    double mTotal = (cacheTotal / 1024) / 1024;
    Directory dDir = Directory((await _download.findLocalPath())!);
    int downTotal = await _reduce(dDir);
    double dTotal = (downTotal / 1024) / 1024;
    // print(mTotal + dTotal);
    return mTotal + dTotal;
  }

  /// 清除缓存
  static Future<void> clear() async {
    await clearCache();
    await clearDownload();
  }

  /// 清除缓存
  static Future<void> clearCache() async {
    await _delete(tempDir);
  }

  static Future clearDownload() async {
    String? path = await _download.findLocalPath();
    // print(path);return;
    List<DownloadTask>? tasks = await _download.getAllLoadTasks();
    tasks
        ?.where((DownloadTask task) => task.savedDir == path)
        .forEach((DownloadTask task) {
      _download.delete(task.taskId);
    });
  }

  /// 递归缓存目录，计算大小
  static Future<int> _reduce(final FileSystemEntity file) async {
    /// 如果是一个文件，则直接返回文件大小
    if (file is File) {
      int length = await file.length();
      return length;
    }

    /// 如果是目录，则遍历目录并累计大小
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();

      int total = 0;

      if (children.isNotEmpty) {
        for (final FileSystemEntity child in children) {
          total += await _reduce(child);
        }
      }

      return total;
    }

    return 0;
  }

  /// 递归删除目录和文件
  static Future<void> _delete(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delete(child);
      }
    } else {
      await file.delete();
    }
  }
}
