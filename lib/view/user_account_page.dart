/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';

import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/cache_image.dart';
import '../utils/helper.dart';
import '../viewmodel/user_model.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '账号设置',
          style: TextStyle(fontSize: 36.w),
        ),
      ),
      body: ProviderWidget<UserModel>(
        provider: userProvider,
        builder: (BuildContext context, UserModel model, ref, Widget? child) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  "头像",
                  style: TextStyle(
                    fontSize: 30.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CacheImage(
                          model.user?.avatar,
                          width: 99.w,
                          height: 99.w,
                        ),
                ),
                onTap: () => _openModalBottomSheet(),
              ),
              Divider(),
              child!,
              ListTile(
                title: Text(
                  "手机号",
                  style: TextStyle(
                    fontSize: 30.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  Helper.emptyValue(model.user?.mobile)
                      ? ''
                      : model.user!.mobile!,
                  style: TextStyle(fontSize: 30.w),
                ),
              ),
              SizedBox(height: 50),
              ListTile(
                title: Center(
                  child: TextButton(
                    onPressed: () async {
                      await model.logout();
                      if (!mounted) return;
                      context.pop();
                    },
                    child: Text(
                      "注销登录",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        child: Column(
          children: [
            ListTile(
              title: Text(
                "昵称",
                style: TextStyle(
                  fontSize: 30.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 48.w,
              ),
              onTap: () => context.pushNamed(Routes.userAccountUsername.name),
            ),
            Divider(),
            ListTile(
              tileColor: Theme.of(context).dividerColor,
              title: Text(
                "账号绑定",
                style: TextStyle(
                  fontSize: 30.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openModalBottomSheet() async {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('从相册选择', textAlign: TextAlign.center),
                onTap: () async {
                  context.pushNamed(Routes.userAccountAvatar.name);
                  Navigator.of(context).pop('file');
                },
              ),
              ListTile(
                title: Text('取消', textAlign: TextAlign.center),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
