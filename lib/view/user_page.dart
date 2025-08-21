/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:zhijian/generated/assets.dart';

import '../generated/l10n.dart';
import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/cache_image.dart';
import '../utils/icon_fonts.dart';
import '../viewmodel/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late double _imgHeight;
  final ValueNotifier<double> _opacity = ValueNotifier(0);

  @override
  void initState() {
    _imgHeight = 445.h;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<UserModel>(
      provider: userProvider,
      onModelReady: (model) => model.getUserInfo(),
      builder: (context, model, ref, child) {
        final stateBarHeight = MediaQuery.of(context).padding.top;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _UserBar(model: model, opacity: _opacity),
          body: EasyRefresh(
            header: _buildBuilderHeader(stateBarHeight, model),
            onRefresh: () {},
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: [
                  HeaderLocator(paintExtent: _imgHeight),
                  child!,
                ],
              ),
            ),
          ),
        );
      },
      child: _buildList(),
    );
  }

  BuilderHeader _buildBuilderHeader(double stateBarHeight, UserModel model) {
    return BuilderHeader(
      clamping: false,
      position: IndicatorPosition.locator,
      triggerOffset: 100000,
      notifyWhenInvisible: true,
      builder: (context, state) {
        final pixels = state.notifier.position.pixels;
        final height = state.offset + _imgHeight;
        double alpha = pixels / (_imgHeight - kToolbarHeight - stateBarHeight);
        if (alpha < 0) {
          alpha = 0;
        } else if (alpha > 1) {
          alpha = 1;
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _opacity.value = alpha;
        });
        return Container(
          height: height,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Assets.imagesUserBg,
                ),
                fit: BoxFit.cover),
          ),
          child: _buildLogin(model),
        );
      },
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        _buildUserTitle(
          title: '历史记录',
          icon: Icons.history,
          onTap: () {
            context.pushNamed(Routes.userHistory.name);
          },
          color: Colors.black54,
        ),
        Divider(),
        _buildUserTitle(
          title: '消息中心',
          icon: Icons.messenger_outline_rounded,
          onTap: () {
            context.pushNamed(Routes.userMessage.name);
          },
          color: Colors.black54,
        ),
        Divider(),
        _buildUserTitle(
          title: '我的收藏',
          icon: Icons.favorite_border,
          onTap: () {
            context.pushNamed(Routes.userFav.name);
          },
          color: Colors.black54,
        ),
        Divider(),
        _buildUserTitle(
          title: '个性设置',
          icon: IconFonts.night,
          onTap: () {
            context.pushNamed(Routes.settingTheme.name);
          },
          color: Colors.black54,
        ),
        Divider(),
        _buildUserTitle(
          title: '青少年模式',
          icon: Icons.accessibility_new,
          onTap: () {
            context.pushNamed(Routes.settingYoung.name);
          },
          color: Colors.black54,
        ),
        Divider(),
        _buildUserTitle(
          title: '设置',
          icon: Icons.settings,
          onTap: () => context.pushNamed(Routes.setting.name),
          color: Colors.black54,
        ),
      ],
    );
  }

  Widget _buildUserTitle(
      {required String title,
      String? subTitle,
      IconData? icon,
      Color? color,
      VoidCallback? onTap}) {
    return SizedBox(
      height: 88.w,
      child: ListTile(
        leading: Icon(
          icon,
          size: 48.w,
          color: color,
        ),
        // contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 10.w,
        minLeadingWidth: 30.w,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 30.w,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        subtitle: subTitle != null ? Text(subTitle) : null,
        trailing: Icon(
          Icons.chevron_right,
          size: 46.w,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogin(UserModel model) {
    return SizedBox(
      height: 220.w,
      child: Column(
        children: [
          SizedBox(height: 25.w),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => model.hasLogin
                ? context.pushNamed(Routes.userShow.name, queryParameters: {
                    'uid': "${model.user?.id}",
                    'showEdit': '1'
                  })
                : context.pushNamed(Routes.userLogin.name),
            child: Container(
              // color: Colors.black,
              height: 150.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Hero(
                    tag: 'hero-user',
                    child: Center(
                      child: ClipOval(
                        child: CacheImage(
                          model.user?.avatar,
                          width: 100.w,
                          height: 100.w,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.hasLogin
                                ? (model.user?.username ?? '匿名')
                                : "登录/注册",
                            style: TextStyle(
                              fontSize: 32.w,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6.w),
                          Text(
                            "欢迎来到知见视频",
                            style: TextStyle(
                              fontSize: 26.w,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserBar extends StatelessWidget implements PreferredSizeWidget {
  final UserModel model;
  final ValueNotifier<double> opacity;

  _UserBar({required this.model, required this.opacity});

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: opacity,
      builder: (context, value, child) {
        return AppBar(
          title: Text(
            S.current.memberCenter,
            style: TextStyle(fontSize: 36.w),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor:
              Theme.of(context).primaryColor.withOpacity(opacity.value),
          actions: [
            model.hasLogin
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.manage_accounts,
                      size: 50.w,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.pushNamed(Routes.userAccount.name);
                    },
                  )
                : SizedBox.shrink()
          ],
        );
      },
    );
  }
}
