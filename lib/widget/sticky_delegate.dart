/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///固定高度的SliverPersistentHeader
class StickyDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).dividerColor,
                offset: Offset(0.0, 10.0), //阴影xy轴偏移量
                blurRadius: 15.0, //阴影模糊程度
                spreadRadius: 1.0 //阴影扩散程度
                )
          ],
        ),
        child: child);
  }

  @override
  double get maxExtent => 50.w;

  @override
  double get minExtent => 50.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
