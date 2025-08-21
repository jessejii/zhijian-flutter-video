/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';

import '../model/video.dart';
import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/config.dart';
import '../utils/icon_fonts.dart';
import '../viewmodel/fav_model.dart';
import '../widget/video_comment_widget.dart';

//视频右侧图标
class PortraitVideoPlayerRight extends StatefulWidget {
  final Video video;

  const PortraitVideoPlayerRight({super.key, required this.video});

  @override
  createState() => _PortraitVideoPlayerRightState();
}

class _PortraitVideoPlayerRightState extends State<PortraitVideoPlayerRight> {
  int get id => widget.video.id;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FavModel>(
        provider: favProvider,
        onModelReady: (model) => model.getAllFav(),
        builder: (context, favModel, ref, child) {
          return SizedBox(
            width: 120.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLikeButton(favModel),
                SizedBox(
                  height: 10.w,
                ),
                _buildPl(),
                SizedBox(
                  height: 10.w,
                ),
                _buildShare()
              ],
            ),
          );
        });
  }

  Widget _buildLikeButton(FavModel favModel) {
    final navigator = GoRouter.of(context);
    return LikeButton(
      onTap: (isLiked) async {
        await favModel.favToggle(
            context: context, infoControl: 'video', infoId: id);
        if (favModel.viewStateError?.isUnauthorized ?? false) {
          navigator.pushNamed(Routes.userLogin.name);
        }
        return favModel.contains(id);
      },
      size: 66.w,
      isLiked: favModel.contains(id),
      // circleColor:
      // CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.pinkAccent,
        dotSecondaryColor: Colors.pinkAccent,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          IconFonts.heart,
          color: isLiked ? Colors.pinkAccent : Colors.white,
          size: 66.w,
        );
      },
      likeCount: widget.video.likeNum,
      countPostion: CountPostion.bottom,
      likeCountPadding: EdgeInsets.only(top: 12.w),
      countBuilder: (int? count, bool isLiked, String text) {
        if (count != null && count < 0) {
          text = '0';
        }
        return Text(
          text,
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }

  Column _buildPl() {
    // var videoListModel= context.read<VideoListModel>();
    return Column(
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.bottomCenter,
            icon: Icon(
              IconFonts.comment,
              size: 66.w,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                builder: (context) {
                  return VideoCommentWidget(video: widget.video);
                },
              );
            }),
        SizedBox(height: 5.w),
        Text(
          widget.video.commentNum.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Column _buildShare() {
    return Column(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.bottomCenter,
          icon: Icon(
            IconFonts.share,
            size: 66.w,
            color: Colors.white,
          ),
          onPressed: () => _onShare(context),
        ),
        SizedBox(height: 5.w),
        Text(
          widget.video.sharedNum.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share('app下载: ${Config.WEB_URL}app/share',
        subject: '分享',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
