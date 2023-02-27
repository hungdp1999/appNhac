import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundVerticalItem extends StatelessWidget {
  final Size sizeImage;
  final String title;
  final String image;
  final String? subTitle;
  final VoidCallback? onTap;

  const RoundVerticalItem({
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
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(sizeImage.width / 2),
              child: CachedNetworkImage(
                imageUrl: image,
                width: sizeImage.width,
                height: sizeImage.height,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                child: Text(
                  title,
                  style: AppStyles.title(
                    context,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (subTitle != null)
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
