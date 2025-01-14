import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  const MyShimmer({
    this.height,
    this.width,
    this.borderRadius,
    this.margin,
    Key? key,
  }) : super(key: key);

  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  const MyShimmer.full({
    super.key,
    this.height = double.infinity,
    this.borderRadius = 0,
    this.width,
    this.margin = EdgeInsets.zero,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: AppColors.oliveGreen70,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          color: Colors.white,
        ),
        margin: margin ?? EdgeInsets.zero,
        width: width ?? double.infinity,
        height: height ?? 300,
      ),
    );
  }
}
