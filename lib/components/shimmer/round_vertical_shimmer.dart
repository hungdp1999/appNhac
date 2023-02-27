import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RoundVerticalShimmer extends StatelessWidget {
  final Size sizeImage;
  final bool hasSubText;
  const RoundVerticalShimmer({
    super.key,
    required this.sizeImage,
    this.hasSubText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: sizeImage.height,
            width: sizeImage.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(sizeImage.height / 2),
              ),
            ),
          ),
          Container(
            height: 10,
            width: sizeImage.width,
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          Container(
            height: 10,
            width: sizeImage.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
