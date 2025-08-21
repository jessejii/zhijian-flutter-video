/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../model/video.dart';
import '../model/view_history.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../utils/application.dart';
import '../utils/cache_image.dart';
import '../viewmodel/history_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isOff = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "观看历史",
          style: TextStyle(fontSize: 36.w),
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            child: Text(
              _isOff ? "编辑" : "取消",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _isOff = !_isOff; //隐藏显示总开关
              });
            },
          ),
        ],
      ),
      body: ProviderWidget<HistoryModel>(
        provider: historyProvider('history'),
        onModelReady: (model) => model.initData(),
        builder:
            (BuildContext context, HistoryModel model, ref, Widget? child) {
          if (model.isBusy) {
            return ViewStateBusyWidget();
          }
          if (model.isError) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
          if (model.list.isEmpty) {
            return ViewStateEmptyWidget();
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.w, right: 15.w),
                  child: EasyRefresh(
                    controller: model.refreshController,
                    onRefresh: model.refresh,
                    onLoad: model.loadMore,
                    child: ListView.builder(
                      itemCount: model.list.length,
                      itemBuilder: (context, index) =>
                          _historyItem(model, index),
                    ),
                  ),
                ),
              ),
              _hisBottom(model),
            ],
          );
        },
      ),
    );
  }

  Widget _historyItem(HistoryModel model, int index) {
    ViewHistory item = model.list[index];

    Video extra = Video(
        id: item.infoId ?? 0,
        pid: item.infoCid ?? 0,
        title: item.title,
        videoUrl: item.videoUrl ?? '');
    return Container(
      height: 150.w,
      margin: EdgeInsets.only(bottom: 20.w),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(Routes.videoDetails.name, extra: extra);
        },
        child: Row(
          children: [
            Offstage(
              offstage: _isOff,
              child: Transform.scale(
                scale: 0.9,
                child: Checkbox(
                  value: model.isChecked(index),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(),
                  onChanged: (value) {
                    model.itemSel(value, index);
                  },
                ),
              ),
            ),
            SizedBox(width: 10.w),
            if (item.thumbnail != null)
              CacheImage(
                item.thumbnail!,
                height: 150.w,
                width: 268.w,
                fit: BoxFit.cover,
              ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: AbsorbPointer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 28.w,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 24.w,
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /*Text((item.author??'').characters
                              .take(3)
                              .toString()),*/
                          Text('${item.viewNum.toString()}人观看'),
                          Text(item.favTime.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //历史底部操作
  Widget _hisBottom(HistoryModel model) {
    return Offstage(
      offstage: _isOff,
      child: Container(
          height: 40,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    value: model.isAllCheck,
                    checkColor: Theme.of(context).hintColor,
                    onChanged: (value) {
                      model.bottomSel(value);
                    },
                  ),
                  Text('全选',
                      style: TextStyle(color: Theme.of(context).hintColor)),
                ],
              ),
              InkWell(
                child: Text('删除',
                    style: TextStyle(color: Theme.of(context).hintColor)),
                onTap: () {
                  model.delByIds();
                },
              ),
            ],
          )),
    );
  }
}
