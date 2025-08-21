/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:collection/collection.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../viewmodel/app_model.dart';
import '../widget/landscape_tab_item_widget.dart';
import '../widget/search_bar_rotate_widget.dart';

class LandscapeVideoPage extends StatefulWidget {
  final AppModel? appModel;

  const LandscapeVideoPage({super.key, this.appModel});

  @override
  createState() => _LandscapeVideoPageState();
}

class _LandscapeVideoPageState extends State<LandscapeVideoPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  AppModel? get appModel => widget.appModel;
  late List<EasyRefreshController> refreshControllers;

  List<Map<String, dynamic>> tabs = [
    {'cid': 1, 'name': '推荐'},
    {'cid': 2, 'name': '影视'},
    {'cid': 3, 'name': '游戏'},
    {'cid': 4, 'name': '搞笑'},
    {'cid': 5, 'name': '综艺'},
    {'cid': 6, 'name': '娱乐'},
    {'cid': 7, 'name': '生活'},
    {'cid': 8, 'name': '美食'},
    {'cid': 9, 'name': '宠物'},
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    refreshControllers =
        List.filled(_tabController.length, EasyRefreshController());

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        appModel
            ?.setLandscapeRefreshController(refreshControllers[_tabController.index]);
        // print(
        //     "listen: ${_tabController.index}--${refreshControllers[_tabController.index].hashCode}");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SearchBarRotateWidget(),
      body: Column(
        children: [
/*      // 去掉高亮和水波纹
      Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      )*/
          Container(
            height: 80.w,
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              // labelColor: Colors.white,
              // unselectedLabelColor: Theme.of(context).highlightColor,
              labelStyle:
                  TextStyle(fontSize: 30.w, fontWeight: FontWeight.bold),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: tabs.map((e) => Text(e['name'])).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabs
                  .mapIndexed((index, e) => LandscapeTabItemWidget(
                        e['cid'],
                        onReady: (EasyRefreshController value) {
                          if (_tabController.index == index) {
                            appModel?.setLandscapeRefreshController(value);
                          }
                          refreshControllers[index] = value;
                          // print("${_tabController.index} ==$index");
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
