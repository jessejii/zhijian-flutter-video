/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../utils/application.dart';

class SettingYoungPage extends StatefulWidget {
  const SettingYoungPage({super.key});

  @override
  createState() => _SettingYoungPageState();
}

class _SettingYoungPageState extends State<SettingYoungPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "青少年模式",
          style: TextStyle(fontSize: 36.w),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '''
    在青少年模式中,我们精选了一批教育类、知识类内容星现在首页,且无法进行充值、打赏等操作,每日晚22时至次日旱6时期间无法使用知见视频。
    开启青少年模式后,将自动开启时间锁,时间锁为40分钟。单日使用时长超过触发时间,需输入密码才能继续使用。开启青少年模式,需先设置独立密码,如忘记密码可通过申诉重置密码。
    青少年模式是知见视频为促进青少年健康成长做出的一次尝试,我们优先针对核心场景进行了优化,也将继续致力于优化更多场景。
            ''',
              style:
                  TextStyle(fontSize: 28.w, color: Theme.of(context).hintColor),
            ),
            ElevatedButton(
              onPressed: () {
                Application.prefs.put('young', true);
                BotToast.showText(
                  text: '开启成功',
                  align: Alignment.center,
                  onClose: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    if (!mounted) return;
                    context.pop();
                  },
                );
              },
              child: Text("开启青少年模式"),
            )
          ],
        ),
      ),
    );
  }
}
