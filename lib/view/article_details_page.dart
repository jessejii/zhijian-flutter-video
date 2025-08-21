/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import '../model/article.dart';
import '../model/parameters.dart';
import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/config.dart';
import '../viewmodel/comment_model.dart';
import '../widget/author_sub_widget.dart';
import '../widget/comment_input_widget.dart';
import '../widget/comment_list_item_widget.dart';

class ArticleDetailsPage extends StatefulWidget {
  final Object? extra;

  const ArticleDetailsPage({super.key, required this.extra});

  @override
  createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  Article? get data => widget.extra as Article?;
  final Completer<bool> _completer = Completer(); //练手,可以用其他代替
  final LongPressGestureRecognizer _longPressGestureRecognizer =
      LongPressGestureRecognizer();

  // final PageController _pageController = PageController();
  final ValueNotifier<bool> _offStage = ValueNotifier(true);

  @override
  void dispose() {
    _offStage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _title(),
      ),
      body: ProviderWidget<CommentModel>(
        provider: commentProvider(CommentParameters(data?.id ?? 0, 'article')),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, ref, child) {
          if (model.isBusy) {
            return SizedBox.shrink();
          } else {
            //busy完成后改为成功
            if (!_completer.isCompleted) {
              _completer.complete(true);
            }
          }

          return Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              children: [
                Expanded(
                  child: Listener(
                    //关闭弹出和表情
                    behavior: _offStage.value
                        ? HitTestBehavior.opaque
                        : HitTestBehavior.deferToChild,
                    onPointerDown: (e) {
                      if (_offStage.value == false) {
                        _offStage.value = true;
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: EasyRefresh(
                      controller: model.refreshController,
                      onRefresh: null,
                      canLoadAfterNoMore: false,
                      onLoad: model.loadMore,
                      child: CustomScrollView(
                        // physics: PageScrollPhysics(),
                        // controller: _pageController,
                        slivers: <Widget>[
                          _titleIntro(data!),
                          SliverToBoxAdapter(
                            child: Html(
                              data: data!.content,
                              style: {
                                "table": Style(
                                  backgroundColor: Color.fromARGB(
                                      0x50, 0xee, 0xee, 0xee),
                                ),
                                "tr": Style(
                                  border: Border(
                                      bottom:
                                      BorderSide(color: Colors.grey)),
                                ),
                                "th": Style(
                                  padding: EdgeInsets.all(6).htmlPadding,
                                  backgroundColor: Colors.grey,
                                ),
                                "td": Style(
                                  padding: EdgeInsets.all(6).htmlPadding,
                                  alignment: Alignment.topLeft,
                                ),
                              },
                            ),
                          ),
                          _report(),
                          SliverToBoxAdapter(
                            child: Text(
                              '评论',
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                    (content, index) {
                                  return CommentListItemWidget(
                                      comment: model.list[index]);
                                }, childCount: model.list.length),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CommentInputWidget(
                  infoId: data?.id ?? 0,
                  offStage: _offStage,
                  infoControl: 'article',
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _report() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 24.w,
            color: Theme.of(context).hintColor,
          ),
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text:
                      '''版权声明：本文内容由互联网或者用户自发贡献，如发现本站有涉嫌抄袭侵权/违法违规的内容， 请发送邮件至'''),
              TextSpan(
                text: '${Config.EMAIL}(长按复制)',
                recognizer: _longPressGestureRecognizer
                  ..onLongPress = () {
                    Clipboard.setData(ClipboardData(text: Config.EMAIL)).then(
                      (value) => BotToast.showText(
                          text: "复制成功",
                          animationDuration: Duration(seconds: 2)),
                    );
                  },
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              TextSpan(text: '举报，一经查实，本站将在第一时间立刻删除。'),
            ]),
          ),
        ),
      ),
    );
  }

  _title() {
    return Theme(
      data: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: _completer.future,
            builder: (context, snapshot) {
              return snapshot.connectionState != ConnectionState.done
                  ? Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: CupertinoActivityIndicator(radius: 10))
                  : SizedBox.shrink();
            },
          ),
          Text(
            '内容详情',
            style: TextStyle(fontSize: 34.w),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  _titleIntro(Article data) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 30.w),
          ),
          SizedBox(height: 10),
          AuthorSubWidget(user: data.user),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _iconShow(data.from, Icons.groups),
              _iconShow(data.author, Icons.person),
              _iconShow(data.viewNum, Icons.remove_red_eye_outlined),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _iconShow(dynamic text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          icon,
          size: 34.w,
          color: Theme.of(context).secondaryHeaderColor,
        ),
        Text(
          "${text ?? ''}",
          style: TextStyle(
            fontSize: 30.w,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        SizedBox(width: 15.w)
      ],
    );
  }
}
