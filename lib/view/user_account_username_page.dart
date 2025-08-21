/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../provider/provider_widget.dart';
import '../viewmodel/user_model.dart';

class UserAccountUsernamePage extends StatefulWidget {
  const UserAccountUsernamePage({super.key});

  @override
  createState() => _UserAccountUsernamePageState();
}

class _UserAccountUsernamePageState extends State<UserAccountUsernamePage> {
  bool isEmpty = true;
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '修改昵称',
          style: TextStyle(fontSize: 36.w),
        ),
      ),
      body: ProviderWidget<UserModel>(
        provider: userProvider,
        builder: (context, model, ref, child) {
          return Column(
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "昵称",
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (String value) {
                  setState(() {
                    isEmpty = (value.trim() == '') ? true : false;
                    name = value;
                  });
                },
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: isEmpty
                      ? null
                      : () async {
                          await model.changeUsername(name);
                          if (!mounted) return;
                          context.pop();
                        },
                  child: Text('确定'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
