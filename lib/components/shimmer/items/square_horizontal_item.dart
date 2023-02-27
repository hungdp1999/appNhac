import 'package:flutter/material.dart';

import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareHorizontalItem extends StatelessWidget {
  final Size sizeImage;
  final String title;
  final String image;
  final String? subTitle;
  final VoidCallback? onTap;
  final Widget? subMenu;
  final bool hidenBg;
  final bool isColorTrending;
  final Color? colorTitle;
  final Color colorBgImage;

  const SquareHorizontalItem({
    super.key,
    required this.sizeImage,
    required this.title,
    required this.image,
    this.subTitle,
    this.onTap,
    this.subMenu,
    this.hidenBg = false,
    this.colorBgImage = Colors.transparent,
    this.colorTitle,
    this.isColorTrending = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: sizeImage.width,
                height: sizeImage.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/default_song.png'))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: !image.contains('http')
                      ? Container(
                          width: sizeImage.width,
                          height: sizeImage.height,
                          color: colorBgImage,
                          alignment: Alignment.center,
                          child: !image.contains('.png')
                              ? SvgPicture.asset(
                                  image,
                                  fit: BoxFit.cover,
                                  width: 24.w,
                                )
                              : Image.asset(
                                  image,
                                  fit: BoxFit.cover,
                                  width: sizeImage.width,
                                  height: sizeImage.height,
                                ),
                        )
                      : CachedNetworkImage(
                          imageUrl: image,
                          width: sizeImage.width,
                          height: sizeImage.height,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) => Container(
                            width: sizeImage.width,
                            height: sizeImage.height,
                            // color: colorBgImage,r
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/default_song.png'))), // width: 24,
                          ),
                        ),
                )),
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
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: colorTitle ?? Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // BlocBuilder<ProPlayerCubit, ProPlayerState>(
                    //   buildWhen: (_, state) => state is ProPlayerLoading,
                    //   builder: (_, state) {
                    //     SongModel _currentSong;
                    //     if (state is ProPlayerLoading) {
                    //       _currentSong = state.song;
                    //     }
                    //     if (state is ProPlayerPlaying) {
                    //       _currentSong = state.song;
                    //     }
                    //     return

                    //     Text(
                    //       title,
                    //       style: AppStyles.title(
                    //         context,
                    //         fontSize: isColorTrending ? 16 : 15,
                    //         fontWeight: isColorTrending
                    //             ? FontWeight.bold
                    //             : FontWeight.w500,
                    //         color: (_currentSong == null ||
                    //                 _currentSong.title != title)
                    //             ? colorTitle
                    //             : isColorTrending
                    //                 ? Colors.black
                    //                 : AppStyles.mainColor,
                    //       ),
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //     );
                    //   },
                    // ),
                    if (subTitle != null && subTitle!.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            subTitle ?? '',
                            style: AppStyles.copyStyle(
                              fontSize: 12.sp,
                              color: colorTitle ?? Const.colorSubtext,
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
