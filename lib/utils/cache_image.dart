/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../generated/assets.dart';

class CacheImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const CacheImage(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return (imageUrl?.isNotEmpty ?? false)
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            width: width,
            height: height,
            fit: fit,
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : Image.asset(
            Assets.imagesNoData,
            width: width,
            height: height,
            fit: fit,
          );
  }
}
