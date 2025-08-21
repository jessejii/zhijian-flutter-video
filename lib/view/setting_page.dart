/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/cache_util.dart';
import '../utils/config.dart';
import '../utils/helper.dart';
import '../viewmodel/app_model.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ValueNotifier<int> cacheSize = ValueNotifier(0);

  @override
  void initState() {
    initCache();
    super.initState();
  }

  @override
  void dispose() {
    cacheSize.dispose();
    super.dispose();
  }

  Future<void> initCache() async {
    /// 获取缓存大小
    double size = await CacheUtil.total();

    /// 四舍五入
    cacheSize.value = size.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '设置',
          style: TextStyle(fontSize: 36.w),
        ),
      ),
      body: ListView(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: cacheSize,
            builder: (context, value, _) {
              return ListTile(
                leading: Icon(
                  Icons.cleaning_services_rounded,
                  size: 48.w,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                horizontalTitleGap: 20.w,
                minLeadingWidth: 50.w,
                title: Text(
                  '本地缓存',
                  style: TextStyle(fontSize: 32.w),
                ),
                subtitle: Text(
                  '清除缓存，但不会清除账号信息',
                  style: TextStyle(fontSize: 24.w),
                ),
                trailing: Text("${value}M"),
                onTap: () => handleClearCache(),
              );
            },
          ),
          Divider(),
          ProviderWidget<AppModel>(
            provider: appProvider,
            builder: (context, model, ref, child) {
              return ListTile(
                leading: Icon(
                  Icons.grade,
                  size: 48.w,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                horizontalTitleGap: 20.w,
                minLeadingWidth: 50.w,
                title: Text(
                  "检查版本",
                  style: TextStyle(
                    fontSize: 30.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Application.packageInfo.version,
                      style: TextStyle(fontSize: 24.w),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 48.w,
                    )
                  ],
                ),
                onTap: () => model.checkAppUpdate(context, mounted,true),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.grade,
              size: 48.w,
              color: Theme.of(context).colorScheme.secondary,
            ),
            horizontalTitleGap: 20.w,
            minLeadingWidth: 50.w,
            title: Text(
              "评分",
              style: TextStyle(
                fontSize: 30.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 48.w,
            ),
            onTap: () => Helper.openStore(),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.info,
              size: 48.w,
              color: Theme.of(context).colorScheme.secondary,
            ),
            horizontalTitleGap: 20.w,
            minLeadingWidth: 50.w,
            title: Text(
              "投诉建议",
              style: TextStyle(
                fontSize: 30.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(Config.EMAIL),
            trailing: Icon(Icons.chevron_right, size: 48.w),
            onTap: () => _launchEmail(),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.info,
              size: 48.w,
              color: Theme.of(context).colorScheme.secondary,
            ),
            horizontalTitleGap: 20.w,
            minLeadingWidth: 50.w,
            title: Text(
              "关于我们",
              style: TextStyle(
                fontSize: 30.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.chevron_right, size: 48.w),
            onTap: () => context.pushNamed(Routes.settingAbout.name),
          ),
        ],
      ),
    );
  }

  //打开email或者复制email
  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: Config.EMAIL,
        queryParameters: {'subject': '您的建议:'});

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      Helper.showToast('无法打开邮件', '已复制邮箱到剪切板');
      Clipboard.setData(ClipboardData(text: Config.EMAIL)).then(
        (value) => BotToast.showText(
            text: "复制成功", animationDuration: Duration(seconds: 2)),
      );
    }
  }

  //清理缓存
  Future<void> handleClearCache() async {
    try {
      if (cacheSize.value == 0) throw '没有缓存可清理';

      /// 给予适当的提示
      bool? confirm = await showDialog(
          context: context,
          // barrierDismissible : false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('确定清理吗?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("取消"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("确定"),
                )
              ],
            );
          });

      if (confirm != true) return;

      /// 执行清除缓存
      await CacheUtil.clear();

      /// 更新缓存
      await initCache();
      BotToast.showText(text: '缓存清除成功');
    } catch (e) {
      BotToast.showText(text: e.toString());
    }
  }
}
