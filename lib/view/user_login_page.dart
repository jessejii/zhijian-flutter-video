/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/config.dart';
import '../utils/helper.dart';
import '../utils/time_down_progress.dart';
import '../utils/validate_utils.dart';
import '../viewmodel/user_model.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //print('bbbb');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '会员登录',
          style: TextStyle(fontSize: 36.w),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 300.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.w),
                  bottomRight: Radius.circular(25.w),
                ),
              ),
              child: Center(
                child: Hero(
                  tag: 'hero-user',
                  child: Image.asset(
                    "assets/images/header.png",
                    width: 150.w,
                    height: 150.w,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.redAccent,
              width: 650.w,
              height: 600.w,
              margin: EdgeInsets.only(top: 250.w),
              child: Card(
                color: Theme.of(context).cardColor,
                elevation: 5.0,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UsernameInput(
                          controller: _nameController,
                        ),
                        Divider(),
                        UserVerifyCode(
                          controller: _passwordController,
                          nameController: _nameController,
                        ),
                        Divider(),
                        LoginButton(
                          passwordController: _passwordController,
                          nameController: _nameController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class LoginButton extends StatefulWidget {
  final TextEditingController? passwordController;
  final TextEditingController? nameController;

  const LoginButton({
    super.key,
    this.passwordController,
    this.nameController,
  });

  @override
  createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _canPress = true;
  bool _radioValue = false;
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<UserModel>(
      provider: userProvider,
      builder: (context, model, ref, child) {
        if (model.isBusy) {
          _canPress = false;
        }
        // print(model.viewState);
        return Column(
          children: [
            ElevatedButton(
              onPressed: _canPress ? () => _onPress(model) : null,
              child: Text(_canPress ? '立即登录' : "登陆中..."),
            ),
            _buildDeal(),
          ],
        );
      },
    );
  }

  //按钮按下
  _onPress(UserModel model) async {
    if (!_radioValue) {
      bool? deal = await _handleDeal();
      if (deal != true) {
        BotToast.showSimpleNotification(
          title: '请同意用户协议',
          titleStyle: TextStyle(fontSize: 30.w),
          hideCloseButton: true,
        );
      } else {
        setState(() {
          _radioValue = true;
        });
      }
      return;
    }

    if (!Form.of(context).validate()) {
      BotToast.showSimpleNotification(
        title: '请确保输入正确',
        titleStyle: TextStyle(fontSize: 30.w),
        hideCloseButton: true,
      );
      return;
    }
    String name = Helper.emptyValue(widget.nameController?.text)
        ? ''
        : widget.nameController!.text;
    String pas = Helper.emptyValue(widget.passwordController?.text)
        ? ''
        : widget.passwordController!.text;

    final navigator = Navigator.of(context);
    bool isLogin = await model.login(name, pas);
    _canPress = true;
    if (isLogin) {
      navigator.pop<bool>(true);
    }
  }

  //协议
  Widget _buildDeal() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            '未注册用户登录后自动注册',
            style:
                TextStyle(color: Theme.of(context).hintColor, fontSize: 22.w),
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(fontSize: 24.w, color: Theme.of(context).hintColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 0.9,
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: Radio<bool>(
                    value: true,
                    groupValue: _radioValue,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) => setState(() {
                      _radioValue = value != null;
                    }),
                    autofocus: true,
                    activeColor: Theme.of(context).colorScheme.primaryContainer,
                    toggleable: true,
                  ),
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: '阅读并同意'),
                TextSpan(
                  text: '用户协议',
                  style: TextStyle(color: Colors.blue, fontSize: 24.w),
                  recognizer: _tapGestureRecognizer
                    ..onTap = () {
                      context.pushNamed(Routes.webView.name, queryParameters: {
                        'url': '${Config.WEB_URL}app/userdeal',
                        'title': '用户协议',
                      });
                    },
                ),
                TextSpan(text: '和'),
                TextSpan(
                    text: '隐私政策',
                    style: TextStyle(color: Colors.blue, fontSize: 24.w),
                    recognizer: _tapGestureRecognizer
                      ..onTap = () {
                        context
                            .pushNamed(Routes.webView.name, queryParameters: {
                          'url': '${Config.WEB_URL}app/privacy',
                          'title': '隐私协议',
                        });
                      }),
              ])),
            ],
          ),
        )
      ],
    );
  }

  //同意协议
  Future<bool?> _handleDeal() async {
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '保护指引',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 34.w),
            ),
            content: Text(
              '请仔细阅读《用户协议》和《隐私政策》,确认是否同意',
              style: TextStyle(fontSize: 28.w),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("拒绝"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("同意"),
              )
            ],
          );
        });
  }
}

/// 带图标的输入框
class UsernameInput extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const UsernameInput({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextFormField(
        controller: widget.controller,
        autofocus: true,
        validator: (v) {
          if (v != null && v.trim().isEmpty) {
            return "请输入手机号码";
          }
          return ValidateUtils.isPhone(v!) ? null : "请输入正确的手机号码";
        },
        decoration: InputDecoration(
          // border: InputBorder.none,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          // contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(Icons.phone_iphone,
              color: Theme.of(context).colorScheme.secondary, size: 44.w),
          // hintText: '请输入手机号',
          // hintStyle: TextStyle(
          //   color: Theme.of(context).inputDecorationTheme.focusColor,
          //   fontSize: 32.w,
          // ),
          labelText: '请输入手机号',
          labelStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.focusColor,
            fontSize: 32.w,
          ),
        ),
      ),
    );
  }
}

class UserVerifyCode extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController nameController;

  const UserVerifyCode(
      {super.key, required this.controller, required this.nameController});

  @override
  createState() => _UserVerifyCodeState();
}

class _UserVerifyCodeState extends State<UserVerifyCode> {
  bool _canTouch = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              validator: (v) {
                if (v == null) {
                  return null;
                }
                if (v.trim().isEmpty) {
                  return "请输入验证码";
                }
                return ValidateUtils.isValidateCaptcha(v) ? null : "请输入正确验证码";
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                prefixIcon: Icon(Icons.verified_outlined,
                    color: Theme.of(context).colorScheme.secondary, size: 44.w),
                // contentPadding: EdgeInsets.zero,
                labelText: '验证码',
                labelStyle: TextStyle(
                  color: Theme.of(context).inputDecorationTheme.focusColor,
                  fontSize: 32.w,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 260.w,
            child: _qrcodeWidget(),
          )
        ],
      ),
    );
  }

  Widget _qrcodeWidget() {
    return _canTouch
        ? Consumer(builder: (context, ref, child) {
            return TextButton(
              onPressed: () {
                if (!checkPhone(widget.nameController.value.text)) {
                  BotToast.showSimpleNotification(
                    title: '请确保手机号码正确',
                    titleStyle: TextStyle(fontSize: 30.w),
                    hideCloseButton: true,
                  );
                  return;
                }

                ref
                    .read(userProvider)
                    .getCode(widget.nameController.value.text);

                setState(() {
                  _canTouch = false;
                });
              },
              child: Text(
                "获取验证码",
                style: TextStyle(
                  fontSize: 24.w,
                ),
              ),
            );
          })
        : TimeDownNum(
            countdownTime: 60,
            perTime: 1,
            build: (context, count) {
              return Text(
                '$count秒后重新获取',
                style: TextStyle(fontSize: 24.w),
              );
            },
            onStop: () {
              setState(() {
                _canTouch = true;
              });
            },
          );
  }

  //是否手机号码
  bool checkPhone(String? v) {
    if (v == null || v.trim().isEmpty || !ValidateUtils.isPhone(v)) {
      return false;
    }

    return true;
  }
}
