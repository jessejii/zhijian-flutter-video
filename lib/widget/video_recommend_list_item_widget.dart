/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';

import '../model/video.dart';
import '../utils/application.dart';
import '../utils/cache_image.dart';

class VideoRecommendListItemWidget extends StatelessWidget {
  final Video video;
  final bool replace;

  const VideoRecommendListItemWidget(
      {super.key, required this.video, this.replace = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (replace) {
          context.pushReplacementNamed(Routes.videoDetails.name, extra: video);
        } else {
          context.pushNamed(Routes.videoDetails.name, extra: video);
        }
      }, //relace动画
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 150.w,
        margin: EdgeInsets.only(bottom: 20.w),
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            CacheImage(
              video.thumbnail,
              height: 150.w,
              width: 268.w,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 28.w,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 24.w,
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('作者:${video.author}'),
                        Text('${video.viewNum}人观看'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
