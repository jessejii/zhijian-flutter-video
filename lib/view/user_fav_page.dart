/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'dart:io';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:zhijian/generated/assets.dart';

import '../model/video.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state.dart';
import '../provider/view_state_widget.dart';
import '../utils/application.dart';
import '../utils/icon_fonts.dart';
import '../viewmodel/fav_model.dart';

class UserFavPage extends StatefulWidget {
  const UserFavPage({super.key});

  @override
  createState() => _UserFavPageState();
}

class _UserFavPageState extends State<UserFavPage> {
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '收藏',
          style: TextStyle(fontSize: 36.w),
        ),
      ),
      body: ProviderWidget<FavListModel>(
        provider: favListProvider,
        onModelReady: (model) => model.initData(),
        builder: (context, model, ref, child) {
          //重新builder
          if (model.isBusy) {
            return ViewStateBusyWidget();
          }
          if (model.isError) {
            return ViewStateErrorWidget(
              error: model.viewStateError,
              onPressed: () => model.initData(),
            );
          }
          if (model.list.isEmpty) {
            return ViewStateEmptyWidget();
          }

          return EasyRefresh(
            controller: _refreshController,
            child: GridView.builder(
              //处理GridView顶部空白
              padding: EdgeInsets.zero,
              itemCount: model.list.length,
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 3,
                  //纵轴间距
                  mainAxisSpacing: 1,
                  //横轴间距
                  crossAxisSpacing: 1,
                  //子组件宽高长度比例
                  childAspectRatio: 9 / 16),
              itemBuilder: (BuildContext context, int index) {
                // print(model.list[index].videoInfo);return Text('123');
                return FavItemWidget(
                  video: model.list[index].videoInfo!,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FavItemWidget extends StatefulWidget {
  final Video video;
  final int index;

  const FavItemWidget({super.key, required this.video, required this.index});

  @override
  createState() => _FavItemWidgetState();
}

class _FavItemWidgetState extends State<FavItemWidget> {
  late Future<String?> _future;

  @override
  void initState() {
    super.initState();
    _future = initThumbnail();
  }

  Future<String?> initThumbnail() async {
    return await VideoThumbnail.thumbnailFile(
      video: widget.video.videoUrl,
      thumbnailPath: Application.tempDir.path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 200,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(Routes.userFavShow.name,
          queryParameters: {'index': "${widget.index}"}),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black),
        child: FutureBuilder<String?>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return ViewStateErrorWidget(
                    error:
                        ViewStateError(ViewStateErrorType.networkTimeOutError),
                  );
                }
                // 请求未结束，显示loading
                return Center(
                  child: Image.asset(
                    Assets.imagesLoadingBg,
                    width: 114.w,
                    height: 29.w,
                  ),
                );
              }

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(snapshot.data!),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    left: 8.w,
                    bottom: 8.w,
                    child: SizedBox(
                      height: 40.w,
                      width: 40.w,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(IconFonts.heart, color: Colors.red),
                        padding: EdgeInsets.zero,
                        iconSize: 38.w,
                        splashRadius: 38.w,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
