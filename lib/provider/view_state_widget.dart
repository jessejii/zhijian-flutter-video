/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:zhijian/generated/assets.dart';

import '../routes/routes.dart';
import '../utils/icon_fonts.dart';
import 'view_state.dart';

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  const ViewStateBusyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPouringHourGlass(
          color: Theme.of(context).colorScheme.secondary),
    );
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback? onPressed;

  const ViewStateWidget(
      {super.key,
      this.image,
      this.title,
      this.message,
      this.buttonText,
      this.onPressed,
      this.buttonTextData});

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Theme.of(context).hintColor, fontSize: 32.w);
    var messageStyle = titleStyle.copyWith(
        color: titleStyle.color!.withOpacity(0.7), fontSize: 28.w);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Center(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification? overscroll) {
                  overscroll!.disallowIndicator();
                  return true;
                },
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    image ??
                        Icon(Icons.error,
                            size: 100.w, color: Theme.of(context).hintColor),
                    Center(
                      child: Text(
                        title ?? '加载失败',
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(child: Text(message ?? '', style: messageStyle)),
                  ],
                ),
              ),
            ),
          ),
        ),
        onPressed != null
            ? ViewStateButton(
                textData: buttonTextData,
                onPressed: () => onPressed?.call(),
                child: buttonText,
              )
            : const SizedBox(),
        const SizedBox(height: 10),
      ],
    );
  }
}

/// ErrorWidget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError? error;
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback? onPressed;

  const ViewStateErrorWidget({
    super.key,
    this.error,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    this.buttonTextData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Icon defaultImage;
    String defaultTitle;
    var errorMessage = error?.message;
    String defaultTextData = '重试';

    switch (error?.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage =
            Icon(Icons.error, size: 90.w, color: Theme.of(context).hintColor);
        defaultTitle = '网络错误';
        errorMessage = null; // 网络异常移除message提示
        break;
      case ViewStateErrorType.defaultError:
        defaultImage =
            Icon(Icons.error, size: 90.w, color: Theme.of(context).hintColor);
        defaultTitle = '加载失败';
        break;

      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
      default:
        defaultImage =
            Icon(Icons.error, size: 90.w, color: Theme.of(context).hintColor);
        defaultTitle = '系统错误';
    }

    return ViewStateWidget(
      onPressed: onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback? onPressed;

  const ViewStateEmptyWidget(
      {super.key, this.image, this.message, this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: onPressed,
      image: Center(
        child: image ?? Image.asset(Assets.imagesNoData, width: 160.w),
      ),
      title: message ?? '空空如也',
      buttonText: buttonText,
      buttonTextData: '刷新一下',
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback? onPressed;

  const ViewStateUnAuthWidget(
      {super.key, this.image, this.message, this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: () => context.pushNamed(Routes.userLogin.name),
      image: image ?? const ViewStateUnAuthImage(),
      title: message ?? '未登录',
      buttonText: buttonText,
      buttonTextData: '登录',
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  const ViewStateUnAuthImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo',
      child: Center(
        child: Icon(
          IconFonts.authorize,
          size: 160.w,
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }
}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? textData;

  const ViewStateButton(
      {super.key, required this.onPressed, this.child, this.textData})
      : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: child ??
            Text(
              textData ?? '重试',
              style: TextStyle(wordSpacing: 5, fontSize: 30.w),
            ));
  }
}
