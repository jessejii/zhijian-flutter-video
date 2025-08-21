/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zhijian/generated/assets.dart';

import '../utils/application.dart';
import '../utils/time_down_progress.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesSplash),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                Assets.imagesHeader,
                width: 150.w,
                height: 150.w,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 100.w,
              right: 60.w,
              child: GestureDetector(
                onTap: _toHome,
                child: Container(
                  width: 100.w,
                  height: 50.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '跳过',
                        style: TextStyle(fontSize: 28.w,color: Colors.white),
                      ),
                      TimeDownNum(
                        countdownTime: 0,
                        perTime: 1,
                        build: (context, count) {
                          return Text(
                            count.toString(),
                            style: TextStyle(fontSize: 26.w,color: Colors.white),
                          );
                        },
                        onStop: _toHome,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toHome() {
    context.pushReplacementNamed(Routes.home.name);
  }
}
