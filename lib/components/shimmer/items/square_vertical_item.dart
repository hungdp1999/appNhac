import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareVerticalItem extends StatelessWidget {
  final Size sizeImage;
  final String title;
  final String image;
  final String? subTitle;
  final VoidCallback? onTap;

  const SquareVerticalItem({
    super.key,
    required this.sizeImage,
    required this.title,
    required this.image,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: sizeImage.width,
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/default_song.png'))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image.contains('http')
                      ? CachedNetworkImage(
                          imageUrl: image,
                          width: sizeImage.width,
                          height: sizeImage.height,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          image,
                          width: sizeImage.width,
                          height: sizeImage.height,
                          fit: BoxFit.cover,
                        ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                title,
                style: AppStyles.title(
                  context,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),
            ),
            if (subTitle != null && subTitle!.isNotEmpty)
              Text(
                subTitle ?? '',
                style: AppStyles.copyStyle(
                  fontSize: 12.sp,
                  color: Const.colorSubtext,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
