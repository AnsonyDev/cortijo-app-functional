import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'my_shimmer/my_shimmer.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage({
    Key? key,
    required this.image,
    this.fit,
    this.width,
    this.height,
  }) : super(key: key);

  final String image;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) => MyShimmer(
        height: height,
        width: width,
        margin: EdgeInsets.zero,
        borderRadius: 1,
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey,
        size: 40,
      ),
      fit: fit,
      width: width,
      height: height,
    );
  }
}
