import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundHorizontalItem extends StatelessWidget {
  final Size sizeImage;
  final String title;
  final String image;
  final String? subTitle;
  final VoidCallback? onTap;
  final Widget? subMenu;
  final bool hidenBg;
  final Color colorBgImage;

  const RoundHorizontalItem({
    super.key,
    required this.sizeImage,
    required this.title,
    required this.image,
    this.subTitle,
    this.onTap,
    this.subMenu,
    this.hidenBg = false,
    this.colorBgImage = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: hidenBg ? Colors.transparent : Const.colorBgCell,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(sizeImage.width / 2),
              child: !image.contains('http')
                  ? Container(
                      width: sizeImage.width,
                      height: sizeImage.height,
                      color: colorBgImage,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: image,
                      width: sizeImage.width,
                      height: sizeImage.height,
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.title(
                        context,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subTitle != null && subTitle!.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Text(
                            subTitle ?? '',
                            style: AppStyles.copyStyle(
                              fontSize: 12.sp,
                              color: Const.colorSubtext,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            if (subMenu != null)
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: subMenu,
              ),
          ],
        ),
      ),
    );
  }
}
