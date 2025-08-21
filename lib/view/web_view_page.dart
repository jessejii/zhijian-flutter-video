/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../provider/provider_widget.dart';
import '../viewmodel/fav_model.dart';

class WebViewPage extends StatefulWidget {
  final Map params;

  const WebViewPage({super.key, required this.params});

  @override
  createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  final ValueNotifier<double> _progress = ValueNotifier(0);

  String get url => widget.params['url'];

  int get id {
    if (widget.params['id'] != null) {
      return int.parse(widget.params['id']);
    } else {
      return 0;
    }
  }

  String? get title => widget.params['title'];

  InAppWebViewController? _webViewController;

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.param);
    // print(id);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(4.w),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.w),
            child: ValueListenableBuilder(
              valueListenable: _progress,
              builder: (BuildContext context, value, Widget? child) {
                return LinearProgressIndicator(
                  minHeight: 4.w,
                  value: _progress.value,
                  color: Colors.blue,
                );
              },
            ),
          ),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            disableContextMenu: true,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          _progress.value = 0.1;
        },
/*        onLoadStop: (controller, url) {
          // print('end');
        },*/
        onLoadHttpError: (controller, url, code, message) {
          BotToast.showText(text: message + code.toString());
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          // print(progress);
          _progress.value = progress / 100;
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;
          if (![
            "http",
            "https",
            "file",
            "chrome",
            "data",
            "javascript",
            "about"
          ].contains(uri.scheme)) {
            // 禁止打开外部app
            return NavigationActionPolicy.CANCEL;
            /*if (await canLaunch(url)) {
              await launch(url);
              // and cancel the request
              return NavigationActionPolicy.CANCEL;
            }*/
          }
          return NavigationActionPolicy.ALLOW;
        },
      ),
      bottomNavigationBar: ProviderWidget<FavModel>(
        provider: favProvider,
        onModelReady: (model) => model.getAllFav(),
        builder: (context, model, ref, child) {
          // print(model.data);
          // print("fav build");
          return Container(
            height: 80.w,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 2.w, color: Theme.of(context).dividerColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => context.pop(), icon: Icon(Icons.close)),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _webViewController?.reload(),
                    child: Text(
                      url,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 28.w,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    id != 0
                        ? IconButton(
                            onPressed: () {
                              model.favToggle(
                                  context: context,
                                  infoControl: 'article',
                                  infoId: id);
                            },
                            icon: model.contains(id)
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(Icons.favorite_border),
                          )
                        : SizedBox.shrink(),
                    IconButton(
                        onPressed: () =>
                            Share.share("$title $url", subject: title),
                        icon: Icon(Icons.share)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
