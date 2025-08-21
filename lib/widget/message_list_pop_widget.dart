/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MessageListPopWidget extends StatelessWidget {
  final String title;
  final Widget? child;

  ///是否屏蔽返回键
  final bool disBackKey;

  const MessageListPopWidget(
      {super.key, required this.title, this.child, this.disBackKey = false});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: disBackKey ? () async => false : null,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: 650.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 80.w,
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: SizedBox(
                        width: 200.w,
                        height: 60.w,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 32.sp,
                              color: Theme.of(context).indicatorColor),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Icon(
                        Icons.close,
                        size: 40.w,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: ShapeDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BeveledRectangleBorder(
                    // side: BorderSide(width: 5, color: Color(0xff00000)),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.w),
                        bottomRight: Radius.circular(10.w)),
                  ),
                ),
                child: Container(
                    alignment: Alignment.topCenter,
                    decoration:
                        BoxDecoration(color: Theme.of(context).colorScheme.background),
                    child: child),
              )
            ],
          ),
        ),
      ),
    );
  }
}
