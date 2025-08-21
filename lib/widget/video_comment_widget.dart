/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/video.dart';
import '../widget/comment_input_widget.dart';
import '../widget/comment_list_widget.dart';

///视频评论部件
class VideoCommentWidget extends StatefulWidget {
  final Video video;

  const VideoCommentWidget({super.key, required this.video});

  @override
  createState() {
    return _VideoCommentWidgetState();
  }
}

class _VideoCommentWidgetState extends State<VideoCommentWidget> {
  ValueNotifier<bool> offStage = ValueNotifier(true);
  late int id;

  @override
  void initState() {
    id = widget.video.id;
    super.initState();
  }

  @override
  void dispose() {
    offStage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (!offStage.value) {
              offStage.value = true;
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            color: Colors.transparent,
            height: 450.w,
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Listener(
                    //关闭弹出和表情
                    onPointerDown: (e) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (offStage.value == false) {
                        offStage.value = true;
                      }
                    },
                    child: Column(
                      children: [
                        _getHeaderLayout(),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10.w),
                          child: CommentListWidget(
                            infoId: id,
                            infoControl: 'video',
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                CommentInputWidget(
                  infoId: id,
                  offStage: offStage,
                  infoControl: 'video',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //头部布局
  _getHeaderLayout() {
    return SizedBox(
      height: 120.w,
      width: 750.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '${widget.video.commentNum}条评论',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.w),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close, size: 60.w),
            ),
          )
        ],
      ),
    );
  }
}
