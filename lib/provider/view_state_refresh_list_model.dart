/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../api/net/http_response.dart';
import 'view_state_list_model.dart';

/// 基于
abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
  /// 分页第一页页码
  static const int pageNumFirst = 1;

  /// 分页条目数量
  static const int pageSize = 20;

  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  EasyRefreshController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  @override
  Future<void> refresh({bool init = false}) async {
    _currentPageNum = pageNumFirst;
    var res = await loadData(pageNum: pageNumFirst);
    if (!res.ok) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      _refreshController.finishRefresh(IndicatorResult.fail);
      setError(res.error);
      return;
    }
    list.clear();
    List<T>? data = res.data;
    if (data == null || data.isEmpty) {
      _refreshController.finishRefresh(IndicatorResult.noMore);
      setEmpty();
    } else {
      onCompleted(data);
      list.addAll(data);
      //刷新后重置加载的状态
      _refreshController.finishRefresh();
      _refreshController.resetFooter();
      // 小于分页的数量,禁止上拉加载更多
      if (data.length < pageSize) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _refreshController.finishLoad(IndicatorResult.noMore);
        });
      }
      setIdle();
    }
  }

  /// 上拉加载更多
  Future<void> loadMore() async {
    var res = await loadData(pageNum: ++_currentPageNum);
    if (!res.ok) {
      _currentPageNum--;
      _refreshController.finishLoad(IndicatorResult.fail);
      return;
    }

    List<T>? data = res.data;
    if (data == null || data.isEmpty) {
      _currentPageNum--;
      _refreshController.finishLoad(IndicatorResult.noMore);
    } else {
      onCompleted(data);
      list.addAll(data);
      if (data.length < pageSize) {
        _refreshController.finishLoad(IndicatorResult.noMore);
      } else {
        _refreshController.finishLoad(IndicatorResult.success);
      }
      setIdle();
    }
  }

  // 加载数据
  @override
  Future<HttpResponse> loadData({int? pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
