/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';

import '../model/video.dart';
import '../utils/application.dart';
import '../utils/cache_image.dart';
import '../utils/open_page_detail.dart';

class LandscapeVideoItemWidget extends StatefulWidget {
  final Video video;

  const LandscapeVideoItemWidget({
    required this.video,
    super.key,
  });

  @override
  createState() => _LandscapeVideoItemWidgetState();
}

class _LandscapeVideoItemWidgetState extends State<LandscapeVideoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.w),
      child: GestureDetector(
        onTap: () => OpenPageDetail.openVideoDetail(context, widget.video),
        child: Column(
          children: [
            SizedBox(
              width: 750.w,
              height: 420.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child:
                        CacheImage(widget.video.thumbnail, fit: BoxFit.fill),
                  ),
                  Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.black54,
                      size: 120.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.w,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 46.w),
                      Text(widget.video.user?.username ?? '')
                    ],
                  ),
                  Spacer(flex: 1),
                  Row(
                    children: [
                      Icon(Icons.comment_outlined, size: 36.w),
                      Text("${widget.video.id}")
                    ],
                  ),
                  SizedBox(width: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


