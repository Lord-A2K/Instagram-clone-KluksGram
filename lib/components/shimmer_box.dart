import 'package:flutter/material.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  double width;
  double height;
  ShimmerBox({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors().primary,
      highlightColor: Color.fromARGB(255, 121, 121, 121),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: AppColors().primary,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
