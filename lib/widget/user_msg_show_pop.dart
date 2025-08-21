/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';

import '../widget/message_list_pop_widget.dart';

class UserMsgShowPop extends StatelessWidget {
  const UserMsgShowPop({this.title, required this.letter, super.key});

  final String? title;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return MessageListPopWidget(
      title: '信件内容',
      child: Column(
        children: [
          Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
            height: 300,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Text(
                letter,
                style: TextStyle(fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
