/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:flutter/material.dart';
import 'package:zhijian/generated/assets.dart';

import '../utils/application.dart';
import '../utils/config.dart';

class SettingAboutPage extends StatefulWidget {
  const SettingAboutPage({super.key});

  @override
  createState() => _SettingAboutPageState();
}

class _SettingAboutPageState extends State<SettingAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '关于我们',
          style: TextStyle(fontSize: 36.w),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                Assets.imagesHeader,
                width: 200.w,
                height: 200.w,
              ),
            ),
            SizedBox(height: 50.w),
            Text(
              '''知见视频汇集了网络上很火的各种短视频资源.
              ''',
              style: TextStyle(
                fontSize: 28.w,
              ),
            ),
            SizedBox(height: 50.w),
            ListTile(
              title: Text(
                "用户协议",
                style: TextStyle(
                  fontSize: 30.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 48.w,
              ),
              onTap: () {
                context.pushNamed(Routes.webView.name, queryParameters: {
                  'url': '${Config.WEB_URL}app/userdeal',
                  'title': '用户协议'
                });
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                "隐私协议",
                style: TextStyle(
                  fontSize: 30.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 48.w,
              ),
              onTap: () {
                context.pushNamed(Routes.webView.name, queryParameters: {
                  'url': '${Config.WEB_URL}app/privacy',
                  'title': '隐私协议'
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
