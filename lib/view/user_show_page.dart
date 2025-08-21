/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zhijian/generated/assets.dart';

import '../model/user.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../utils/application.dart';
import '../utils/cache_image.dart';
import '../utils/config.dart';
import '../viewmodel/user_model.dart';
import '../widget/article_widget.dart';
import '../widget/video_recommend_widget.dart';

class UserShowPage extends StatefulWidget {
  final Map<String, String> params;

  const UserShowPage({super.key, required this.params});

  @override
  createState() => _UserShowPageState();
}

class _UserShowPageState extends State<UserShowPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _tabs = [
    {'cid': 5, 'name': '文章'},
    {'cid': 1, 'name': '视频'},
  ];

  int get uid =>
      widget.params['uid'] != null ? int.parse(widget.params['uid']!) : 0;

  int? get showEdit => widget.params['showEdit'] != null
      ? int.parse(widget.params['showEdit']!)
      : 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // print(uid);
    return Scaffold(
      //MediaQuery.removePadding
      body: ProviderWidget<UserPubModel>(
        provider: userPubProvider(uid),
        onModelReady: (model) => model.initData(),
        builder: (context, model, ref, child) {
          if (model.isBusy) {
            return SizedBox.shrink();
          }
          if (model.isError) {
            return ViewStateErrorWidget(
                error: model.viewStateError,
                onPressed: () => model.initData());
          }
          return NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                _flexSliverAppBar(),
                _flexSliverToBoxAdapter(model.data!),
                _flexSliverPersistentHeader(),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                ArticleWidget(3, uid: uid),
                VideoRecommendWidget(1, uid: uid)
              ],
            ),
          );
        },
      ),
    );
  }

  _flexSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      //是否可拉伸伸展
      stretchTriggerOffset: 100.w,
      onStretchTrigger: () async {
        // print('123');
        return;
      },
      title: Text(
        '个人主页',
        style: TextStyle(fontSize: 36.w),
      ),
      centerTitle: true,
      expandedHeight: 300.w,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(Icons.arrow_back),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          // StretchMode.fadeTitle,
          // StretchMode.blurBackground
        ],
        background: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Color(0xffd4d3dd)
                  ]),
              image: DecorationImage(
                  image: AssetImage(Assets.imagesUserCircle),
                  fit: BoxFit.fill)),
        ),
      ),
      actions: [
        IconButton(
          onPressed: _onShare,
          icon: Icon(Icons.more_horiz, size: 50.w),
        ),
      ],
    );
  }

  _onShare() async {
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share('app下载: ${Config.WEB_URL}app/share',
        subject: '分享',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  _flexSliverToBoxAdapter(User data) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 140.w,
              child: Row(
                children: [
                  Container(
                    height: 140.w,
                    width: 140.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44),
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Colors.black,
                        width: 4.w,
                      ),
                    ),
                    child: ClipOval(
                      child: CacheImage(
                        data.avatar,
                        width: 99.w,
                        height: 99.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                  SizedBox(
                    height: 100.w,
                    child: VerticalDivider(
                        width: 2.w, color: Theme.of(context).hintColor),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('获赞',
                                style: TextStyle(
                                    color: Theme.of(context).hintColor)),
                            Text(
                              '0',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('关注',
                                style: TextStyle(
                                    color: Theme.of(context).hintColor)),
                            Text(
                              '0',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('粉丝',
                                style: TextStyle(
                                    color: Theme.of(context).hintColor)),
                            Text(
                              '0',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.username,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 32.w),
                    ),
                    showEdit == 1
                        ? GestureDetector(
                            onTap: () =>
                                context.pushNamed(Routes.userAccount.name),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.manage_accounts,
                                  size: 38.w,
                                  color: Theme.of(context).hintColor,
                                ),
                                Text(
                                  '编辑',
                                  style: TextStyle(
                                    fontSize: 30.w,
                                    color: Theme.of(context).hintColor,
                                  ),
                                )
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 20.w),
                ReadMoreText(
                  data.intro!,
                  trimLines: 2,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 28.w,
                  ),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '展开',
                  trimExpandedText: '收缩',
                  moreStyle:
                      TextStyle(fontSize: 28.w, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _flexSliverPersistentHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabs.map((e) => Tab(text: e['name'])).toList(),
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).dividerColor,
                offset: Offset(0.0, 10.0), //阴影xy轴偏移量
                blurRadius: 15.0, //阴影模糊程度
                spreadRadius: 1.0 //阴影扩散程度
                )
          ],
        ),
        child: child);
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
