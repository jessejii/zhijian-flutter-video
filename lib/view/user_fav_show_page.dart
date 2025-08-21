/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zhijian/generated/assets.dart';

import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../viewmodel/fav_model.dart';
import '../widget/portrait_video_widget.dart';

class UserFavShowPage extends StatefulWidget {
  final Map params;

  const UserFavShowPage({super.key, required this.params});

  @override
  createState() => _UserFavShowPageState();
}

class _UserFavShowPageState extends State<UserFavShowPage> {
  late PageController _pageController;
  late int showIndex;

  @override
  void initState() {
    showIndex = int.parse(widget.params['index'][0]);
    _pageController = PageController(keepPage: true, initialPage: showIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            ProviderWidget<FavShowListModel>(
                provider: favShowListProvider,
                onModelReady: (model) async => model.initData(),
                builder: (context, FavShowListModel model, ref, child) {
                  if (model.isBusy || model.isEmpty) {
                    return Center(
                      child: Image.asset(
                        Assets.imagesLoadingBg,
                        width: 114.w,
                        height: 29.w,
                      ),
                    );
                  }
                  if (model.isError) {
                    return ViewStateErrorWidget(
                      error: model.viewStateError,
                      onPressed: () => model.initData(),
                    );
                  }
                  return EasyRefresh(
                    header: MaterialHeader(),
                    onRefresh: model.refresh,
                    controller: model.refreshController,
                    onLoad: model.loadMore,
                    callLoadOverOffset: 50,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      itemCount: model.list.length,
                      itemBuilder: (context, index) {
                        // print('itembuilder:$index');
                        return PortraitVideoWidget(video: model.list[index]);
                      },
                    ),
                  );
                }),
            Positioned(
              top: 20.w,
              left: 20.w,
              child: IconButton(
                alignment: Alignment.topLeft,
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 60.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
