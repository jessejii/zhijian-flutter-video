/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/message.dart';
import '../provider/provider_widget.dart';
import '../provider/view_state_widget.dart';
import '../viewmodel/message_model.dart';
import '../widget/user_msg_show_pop.dart';

class UserMessagePage extends StatefulWidget {
  const UserMessagePage({super.key});

  @override
  createState() => _UserMessagePageState();
}

class _UserMessagePageState extends State<UserMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('消息中心', style: TextStyle(fontSize: 36.w)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ProviderWidget<MessageListModel>(
          provider: messageListProvider,
          onModelReady: (model) => model.initData(),
          builder: (context, model, ref, child) {
            // print(model.viewState);
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
            if (model.isEmpty) {
              return ViewStateEmptyWidget();
            }
            return EasyRefresh(
              controller: model.refreshController,
              onRefresh: model.refresh,
              onLoad: model.loadMore,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: model.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return _messageItem(model.list[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  GestureDetector _messageItem(Message message) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => UserMsgShowPop(
                  title: message.title.isEmpty ? '暂无标题' : message.title,
                  letter: (message.content?.isEmpty ?? true)
                      ? '暂无内容'
                      : message.content!,
                ));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.mark_email_read_outlined, size: 22),
              SizedBox(width: 5),
              Expanded(
                  child: Text(
                message.title.isEmpty ? '暂无标题' : message.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              Text(message.createTime ?? DateTime.now().toString())
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
