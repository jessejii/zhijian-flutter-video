/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:collection/collection.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';
import '../viewmodel/app_model.dart';
import '../widget/article_widget.dart';

class ArticlePage extends StatefulWidget {
  final AppModel? appModel;

  const ArticlePage({super.key, this.appModel});

  @override
  createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  AppModel? get appModel => widget.appModel;
  late List<EasyRefreshController> refreshControllers;

  @override
  bool get wantKeepAlive => true;
  List<Map<String, dynamic>> tabs = [
    {'cid': 3, 'name': S.current.news},
    {'cid': 4, 'name': S.current.recommend},
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    refreshControllers =
        List.filled(_tabController.length, EasyRefreshController());

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        appModel?.setArticleRefreshController(
            refreshControllers[_tabController.index]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 80.w,
          child: Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelStyle:
                  TextStyle(fontSize: 30.w, fontWeight: FontWeight.bold),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              tabs: tabs.map((e) => Text(e['name'])).toList(),
              dividerColor: Colors.transparent,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.mapIndexed((index, e) {
          return ArticleWidget(
            e['cid'],
            onReady: (EasyRefreshController value) {
              if (_tabController.index == index) {
                appModel?.setArticleRefreshController(value);
              }
              refreshControllers[index] = value;
            },
          );
        }).toList(),
      ),
    );
  }
}
