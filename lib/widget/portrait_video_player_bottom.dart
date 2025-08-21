/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

//视频底部标题
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/helper.dart';

class PortraitVideoPlayerBottom extends StatelessWidget {
  final String? author;

  const PortraitVideoPlayerBottom({super.key, this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.w,
      padding: EdgeInsets.only(left: 30.w),
      child: Text(
        Helper.emptyValue(author) ? '' : "@$author",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 32.w,
        ),
      ),
    );
  }
}
