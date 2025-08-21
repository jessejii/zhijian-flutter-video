/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../routes/routes.dart';

/*
可以直接使用PreferredSize
return PreferredSize(
child: AppBar(
),
preferredSize: preferredSize,
);*/
class SearchBarRotateWidget extends StatelessWidget
    implements PreferredSizeWidget {
  SearchBarRotateWidget({super.key});
  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: GestureDetector(
        onTap: () => context.pushNamed(Routes.search.name),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  context.pushNamed(Routes.userMessage.name);
                },
                icon: Image.asset(
                  "assets/images/header.png",
                  width: 30,
                  height: 30,
                )),
            Expanded(
              child: AbsorbPointer(
                child: Container(
                  height: 80.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.black38, size: 34.w),
                      SizedBox(
                        width: 10.w,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText(
                            '搜索你喜爱的',
                            textStyle: TextStyle(
                                fontSize: 30.sp, color: Colors.black38),
                            duration: Duration(seconds: 5),
                          ),
                          RotateAnimatedText(
                            '探索新世界',
                            textStyle: TextStyle(
                                fontSize: 30.sp, color: Colors.black38),
                            duration: Duration(seconds: 5),
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        pause: Duration(seconds: 1),
                        onTap: () {
                          // print("Tap Event");
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.userHistory.name);
              },
              color: Colors.white,
              icon: Icon(Icons.history),
            ),
          ],
        ),
      ),
    );
  }
}
/*
TextField(
decoration: InputDecoration(
contentPadding: EdgeInsets.zero,
fillColor: Color(0x30cccccc),
filled: true,
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(color: Color(0x00FF0000)),
borderRadius: BorderRadius.all(Radius.circular(5))),
hintText: 'QQ号/手机号/邮箱3',

focusedBorder: OutlineInputBorder(
borderSide: BorderSide(color: Color(0x00000000)),
borderRadius: BorderRadius.all(Radius.circular(5))),
),
)*/
