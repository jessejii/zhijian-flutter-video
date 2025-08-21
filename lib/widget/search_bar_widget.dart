/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

/*
搜索AppBar
可以直接使用PreferredSize
return PreferredSize(
child: AppBar(
),
preferredSize: preferredSize,
);*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const SearchBarWidget({
    super.key,
    this.borderRadius = 20,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.height = 40,
    this.value,
    this.leading,
    this.suffix,
    this.actions = const [],
    this.hintText,
    this.onTap,
    this.onClear,
    this.onCancel,
    this.onChanged,
    this.onSearch,
    this.onRightTap,
  });
  final double? borderRadius;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  // 输入框高度 默认40
  final double height;

  // 默认值
  final String? value;

  // 最前面的组件
  final Widget? leading;

  // 背景色

  // 搜索框内部后缀组件
  final Widget? suffix;

  // 搜索框右侧组件
  final List<Widget> actions;

  // 输入框提示文字
  final String? hintText;

  // 输入框点击回调
  final VoidCallback? onTap;

  // 清除输入框内容回调
  final VoidCallback? onClear;

  // 清除输入框内容并取消输入
  final VoidCallback? onCancel;

  // 输入框内容改变
  final ValueChanged<String>? onChanged;

  // 点击键盘搜索
  final ValueChanged<String>? onSearch;

  // 点击右边widget
  final VoidCallback? onRightTap;

  @override
  SearchBarWidgetState createState() => SearchBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  bool get isFocus => _focusNode?.hasFocus ?? false; //是否获取焦点

  bool get isTextEmpty => _controller?.text.isEmpty ?? false; //输入框是否为空

  bool get isActionEmpty => widget.actions.isEmpty; // 右边布局是否为空

  bool isShowCancel = false;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.value != null) _controller?.text = widget.value ?? "";
    // 焦点获取失去监听
    // _focusNode?.addListener(() => setState(() {}));
    // 文本输入监听
    _controller?.addListener(() => setState(() {}));
    super.initState();
  }

  // 清除输入框内容
  void _onClearInput() {
    _controller?.clear();
    widget.onClear?.call();
  }

/*  // 取消输入框编辑失去焦点
  void _onCancelInput() {
    _controller?.clear();
    _focusNode?.unfocus(); //失去焦点
    // 执行onCancel
    widget.onCancel?.call();
  }*/

  Widget _suffix() {
    if (!isTextEmpty) {
      return InkWell(
        onTap: _onClearInput,
        child: SizedBox(
          width: widget.height,
          height: widget.height,
          child: Icon(Icons.cancel, size: 50.w, color: Color(0xFF999999)),
        ),
      );
    }
    return widget.suffix ?? SizedBox();
  }

  List<Widget> _actions() {
    List<Widget> list = [];
    if (isFocus || !isTextEmpty) {
      /*list.add(InkWell(
        onTap: widget.onRightTap ?? _onCancelInput,
        child: Container(
          constraints: BoxConstraints(minWidth: 48.w),
          alignment: Alignment.center,
          child: Text(
            '搜索',
            style: TextStyle(
              fontSize: 14.w,
            ),
          ),
        ),
      ));*/
    } else if (!isActionEmpty) {
      list.addAll(widget.actions);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //阴影z轴
      elevation: 0,
      // 标题与其他控件的间隔
      titleSpacing: 0,
      leadingWidth: 60.w,
      leading: widget.leading,
      title: Container(
          margin: EdgeInsets.all(30.w),
          height: widget.height,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          ),
          child: Row(
            children: [
              SizedBox(width: 20.w),
              Expanded(
                child: TextField(
                  autofocus: widget.autoFocus ?? false,
                  focusNode: _focusNode,
                  controller: _controller,
                  textAlignVertical: TextAlignVertical.center,
                  //装饰
                  decoration: InputDecoration(
                    filled: true,
                    //设置为true，fillColor才有效
                    fillColor: Theme.of(context).cardColor,
                    //背景颜色
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    // focusedBorder: OutlineInputBorder(
                    //     gapPadding: 0, borderSide: BorderSide.none),
                    // enabledBorder: OutlineInputBorder(
                    //     gapPadding: 0, borderSide: BorderSide.none),

                    hintText: widget.hintText ?? '请输入关键字',
                    hintStyle: TextStyle(fontSize: 28.sp),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 40.w,
                      color: Color(0xFF999999),
                    ),
                    prefixIconConstraints:
                        BoxConstraints.expand(height: 75.w, width: 75.w),
                  ),

                  style: TextStyle(fontSize: 28.sp,color: Theme.of(context).highlightColor),
                  // 键盘动作右下角图标
                  textInputAction: TextInputAction.search,
                  onTap: widget.onTap,
                  // 输入框内容改变回调
                  onChanged: (value) {
                    widget.onChanged?.call(value);
                    if (value == '') {
                      widget.onClear?.call();
                    }
                  },
                  onSubmitted: widget.onSearch, //输入框完成触发
                ),
              ),
              SizedBox(width: 20.w),
              _suffix(),
            ],
          )),
      actions: _actions(),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }
}
