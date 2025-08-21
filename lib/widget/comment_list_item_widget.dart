/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

import '../model/comment.dart';
import '../utils/icon_fonts.dart';

class CommentListItemWidget extends StatelessWidget {
  final Comment comment;

  const CommentListItemWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        comment.userAvatar!.trim().isNotEmpty
            ? CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider("${comment.userAvatar}"),
                backgroundColor: Colors.red,
                radius: 40.w,
              )
            : CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/no-avatar.jpg",
                ),
                backgroundColor: Colors.red,
                radius: 40.w,
              ),
        SizedBox(width: 10),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.userName!.isNotEmpty ? comment.userName! : "匿名",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.w),
            ),
            SizedBox(height: 5),
            Text(
              comment.content,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(comment.createTime!,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                SizedBox(width: 5),
                /*GestureDetector(
                  onTap: () => print('123'),
                  child: Text(
                    '回复',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),*/
              ],
            )
          ],
        )),
        SizedBox(width: 10),
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LikeButton(
              onTap: (isLiked) async =>null,
              size: 50.w,
              isLiked: false,
              // circleColor:
              // CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.pinkAccent,
                dotSecondaryColor: Colors.pinkAccent,
              ),
              likeBuilder: (bool isLiked) {
                return Center(
                  child: Icon(
                    IconFonts.heart,
                    color: isLiked ? Colors.pinkAccent : Colors.black38,
                    size: 38.w,
                  ),
                );
              },
            ),
            Text(
              "${comment.heartNum}",
              style: TextStyle(fontSize: 24.w, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
