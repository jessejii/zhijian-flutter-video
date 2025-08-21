/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/parameters.dart';
import '../model/video.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../utils/cache_image.dart';
import '../utils/open_page_detail.dart';
import '../viewmodel/home_video_model.dart';
import '../viewmodel/search_history_model.dart';
import '../widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _editingController;
  bool _showResult = false;

  @override
  void initState() {
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setResult(String value) {
    setState(() {
      value != '' ? _showResult = true : _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SearchHistoryModel>(
        provider: searchProvider,
        onModelReady: (model) => model.initData(),
        builder: (BuildContext context, SearchHistoryModel model, ref,
            Widget? child) {
          return Scaffold(
            appBar: SearchBarWidget(
              controller: _editingController,
              onSearch: (value) {
                model.setSearchKey(value);
                setResult(value);
              },
              onClear: () {
                model.setSearchKey('');
                setResult('');
              },
            ),
            body: _showResult
                ? SearchListWidget(
                    searchKey: model.searchKey,
                    key: ValueKey(model.searchKey),
                  )
                : SearchMainWidget(
                    model: model,
                    editingController: _editingController,
                    onChange: (value) {
                      setResult(value);
                    },
                  ),
          );
        });
  }
}

class SearchMainWidget extends StatelessWidget {
  final TextEditingController editingController;
  final SearchHistoryModel model;
  final ValueChanged onChange;

  const SearchMainWidget({
    super.key,
    required this.editingController,
    required this.model,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '搜索历史',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_forever),
                iconSize: 18,
                onPressed: () {
                  model.removeAll();
                },
                splashRadius: 15,
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            height: 52,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(model.list.length, (index) {
                  return _sortText(
                      showTxt: model.list[index].title.characters
                          .take(6)
                          .toString());
                }),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '热门搜索',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              children: [
                _sortText(showTxt: '世界杯', width: 250.w, showNum: true),
                _sortText(showTxt: '狄仁杰', width: 250.w, showNum: true),
                _sortText(showTxt: '纪晓岚', width: 250.w, showNum: true),
                _sortText(showTxt: '哈哈', width: 250.w, showNum: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sortText(
      {required String showTxt, double? width, bool showNum = false}) {
    return GestureDetector(
      onTap: () {
        editingController.text = showTxt;
        model.setSearchKey(showTxt);
        onChange.call(showTxt);
        editingController.selection =
            TextSelection.fromPosition(TextPosition(offset: showTxt.length));
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 10, bottom: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showNum
                ? Container(
                    width: 20,
                    height: 20,
                    color: Colors.deepOrangeAccent,
                    child: Center(
                        child: Text(
                      "10",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  )
                : SizedBox.shrink(),
            SizedBox(width: 2),
            Text(showTxt, style: TextStyle(fontSize: 26.w)),
          ],
        ),
      ),
    );
  }
}

class SearchListWidget extends StatefulWidget {
  final String? searchKey;

  const SearchListWidget({super.key, this.searchKey});

  @override
  State<SearchListWidget> createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeVideoListModel>(
      provider: homeVideoListProvider(
          HomeVideoListParameters(2, searchKey: widget.searchKey)),
      onModelReady: (model) => model.initData(),
      builder: (context, model, ref, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        } else if (model.isError) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        if (model.list.isEmpty) {
          return ViewStateEmptyWidget();
        }
        return Padding(
          padding: EdgeInsets.all(10),
          child: EasyRefresh(
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoad: model.loadMore,
            child: ListView.builder(
              itemBuilder: (context, index) => _searchItem(model.list[index]),
              itemCount: model.list.length,
              cacheExtent: 6,
            ),
          ),
        );
      },
    );
  }

  Widget _searchItem(Video video) {
    return GestureDetector(
      onTap: () => OpenPageDetail.openVideoDetail(context, video),
      child: Container(
        height: 200.w,
        padding: EdgeInsets.symmetric(vertical: 15.w),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.black38,
            // color: Theme.of(context).backgroundColor,
            width: 2.w,
          )),
        ),
        child: Row(
          children: [
            SizedBox(
                width: 50,
                height: 60,
                child: CacheImage(
                  video.thumbnail,
                  width: 99.w,
                  height: 99.w,
                  fit: BoxFit.fitHeight,
                ),),
            SizedBox(width: 20.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '片名:${video.title.characters.take(16)}',
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.w,
                  ),
                ),
                Text(
                  '类别: ${video.pid}',
                  style: TextStyle(
                    fontSize: 26.w,
                  ),
                ),
                Text(
                  '主演: ${video.author}',
                  style: TextStyle(
                    fontSize: 26.w,
                  ),
                ),
                Text(
                  '年份: ${video.createTime ?? '暂无'}',
                  style: TextStyle(
                    fontSize: 26.w,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
