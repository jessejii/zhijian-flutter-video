/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../model/parameters.dart';
import '../provider/provider_widget.dart';
import '../utils/application.dart';
import '../utils/icon_fonts.dart';
import '../viewmodel/comment_model.dart';

class CommentInputWidget extends StatefulWidget {
  final int infoId;
  final String infoControl;
  final ValueNotifier<bool> offStage;

  const CommentInputWidget({
    super.key,
    required this.infoControl,
    required this.infoId,
    required this.offStage,
  });

  @override
  createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  late Future _future;
  final TextEditingController _editingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _showSend = ValueNotifier(false);

  String get infoControl => widget.infoControl;

  @override
  void initState() {
    _future =
        DefaultAssetBundle.of(context).loadString("assets/json/emoji.json");
    _editingController.addListener(() {
      //监控是否输入文字.
      _editingController.text.isNotEmpty
          ? _showSend.value = true
          : _showSend.value = false;
    });

    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _showSend.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 50),
        child: Column(
          children: [
            Divider(
              color: Colors.grey[300],
              height: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80.w,
                    padding: EdgeInsets.only(top: 5.w, bottom: 5.w, left: 15.w),
                    child: TextField(
                      controller: _editingController,
                      focusNode: _focusNode,
                      style: TextStyle(
                        fontSize: 26.w,
                      ),
                      autofocus: true,
                      /*textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (String value) {

                      },*/
                      /* onChanged: (value) {

                      },*/
                      decoration: InputDecoration(
                        fillColor: Color(0x30cccccc),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        hintText: '  发表您的精彩留言吧~',
                        hintStyle: TextStyle(fontSize: 26.w),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (widget.offStage.value == true) {
                              widget.offStage.value = false;
                              _focusNode.unfocus();
                            } else {
                              FocusScope.of(context).requestFocus(_focusNode);
                              widget.offStage.value = true;
                            }
                          },
                          splashRadius: 40.w,
                          icon: ValueListenableBuilder<bool>(
                            valueListenable: widget.offStage,
                            builder: (context, value, child) {
                              return Icon(
                                widget.offStage.value
                                    ? IconFonts.smile
                                    : Icons.keyboard,
                                size: 45.w,
                                color: Colors.grey[700],
                              );
                            },
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _showSend,
                  builder: (context, value, child) {
                    return value ? _sendButton() : SizedBox();
                  },
                ),
              ],
            ),
            _emoJiList()
          ],
        ),
      ),
    );
  }

  Widget _sendButton() {
    return ProviderWidget<CommentModel>(
      provider:
          commentProvider(CommentParameters(widget.infoId, widget.infoControl)),
      builder: (context, CommentModel model, ref, child) {
        return IconButton(
          onPressed: () async {
            var value = _editingController.text;
            if (value.length < 6) {
              BotToast.showSimpleNotification(
                title: '您输入的内容必须大于6个',
                titleStyle: TextStyle(fontSize: 30.w),
                hideCloseButton: true,
              );
              return;
            }
            var cancel = BotToast.showLoading(); //弹出一个加载动画
            bool isSend = await model.addComment(content: value);
            if (model.viewStateError?.isUnauthorized ?? false) {
              if (!mounted) return;
              context.pushNamed(Routes.userLogin.name);
            }
            cancel(); //关闭
            if (isSend) {
              BotToast.showSimpleNotification(
                title: '发送成功',
                titleStyle: TextStyle(fontSize: 30.w),
                hideCloseButton: true,
              );
              _editingController.text = '';
            }
            widget.offStage.value = true;
            _focusNode.unfocus();
          },
          icon: Icon(
            IconFonts.send,
            size: 40.w,
            color: Theme.of(context).hintColor,
          ),
          padding: EdgeInsets.zero,
          splashRadius: 40.w,
        );
      },
    );
  }

  _emoJiList() {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.offStage,
      builder: (BuildContext context, value, Widget? child) {
        return Offstage(
          offstage: widget.offStage.value,
          child: Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.white,
            height: 400.w,
            child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<dynamic> data = jsonDecode(snapshot.data.toString());
                  return GridView.custom(
                    padding: EdgeInsets.all(3),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      mainAxisSpacing: 2.w,
                      crossAxisSpacing: 2.w,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTapUp: (_) {
                            String text = _editingController.text;
                            TextSelection textSelection =
                                _editingController.selection;
                            String newText = text.replaceRange(
                                textSelection.start,
                                textSelection.end,
                                String.fromCharCode(data[index]["unicode"]));
                            final emojiLength =
                                String.fromCharCode(data[index]["unicode"])
                                    .length;
                            _editingController.text = newText;
                            _editingController.selection =
                                textSelection.copyWith(
                              baseOffset: textSelection.start + emojiLength,
                              extentOffset: textSelection.start + emojiLength,
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Center(
                            child: Text(
                              String.fromCharCode(data[index]["unicode"]),
                              style: TextStyle(fontSize: 50.w),
                            ),
                          ),
                        );
                      },
                      childCount: data.length,
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
