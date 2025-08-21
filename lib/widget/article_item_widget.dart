/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:flutter/material.dart';

import '../model/article.dart';
import '../utils/application.dart';
import '../utils/cache_image.dart';
import '../utils/helper.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;

  const ArticleItemWidget(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("redirect ${article.redirect}");
        if (article.redirect == 1 && article.fromUrl != '') {
          // print("${article.id}-${article.fromUrl}-${article.title}");return;
          context.pushNamed(Routes.webView.name, queryParameters: {
            'id': article.id.toString(),
            'url': article.fromUrl,
            'title': article.title
          });
        } else {
          context.pushNamed(Routes.articleDetails.name, extra: article);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: !Helper.emptyValue(article.thumbnail)
                ? CacheImage(
                    article.thumbnail,
                    height: 300.w,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  )
                : SizedBox.shrink(),
          ),
          Container(
            height: 120.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor),
            // alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 32.w, fontWeight: FontWeight.w500),
                      ),
                    )),
                Icon(
                  Icons.chevron_right_outlined,
                  size: 60.w,
                  color: Colors.black54,
                )
              ],
            ),
          ),
          // Divider(),
        ],
      ),
    );
  }
}
