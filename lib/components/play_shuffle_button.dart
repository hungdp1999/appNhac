import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayShuffleButton extends StatelessWidget {
  final Function? onPlay;
  final Function? onShuffle;
  final Function? onAddSong;

  const PlayShuffleButton({
    super.key,
    this.onPlay,
    this.onShuffle,
    this.onAddSong,
  });

  @override
  Widget build(BuildContext context) {
    if (onPlay == null && onShuffle != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 103),
        child: _customButton(
            AppIcons.icShuffleSvg, 'Shuffle', onShuffle ?? () {}, context, 24),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onPlay != null && onShuffle != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customButton(
                  AppIcons.icPlay,
                  'play'.tr()
                  // LocaleKeys.play.tr()
                  ,
                  onPlay ?? () {},
                  context,
                  15,
                  isGradient: true),
              _customButton(
                  AppIcons.icShuffleSvg,
                  'shuffle'.tr()
                  // LocaleKeys.shuffle.tr()
                  ,
                  onShuffle ?? () {},
                  context,
                  24),
            ],
          ),
        if (onAddSong != null)
          InkWell(
            onTap: () => onAddSong!(),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppStyles.grey3),
                borderRadius: BorderRadius.circular(25 / 2),
              ),
              height: ScreenUtil().setHeight(25),
              width: ScreenUtil().setWidth(112),
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: Const.paddingHorizon,
                bottom: ScreenUtil().setHeight(24),
              ),
              child: Text(
                'addmoresong'.tr(),
                // LocaleKeys.addmoresong.tr(),
                style: AppStyles.title(
                  context,
                  fontSize: 11,
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _customButton(String icon, String title, Function? onPress,
      BuildContext context, double size,
      {bool isGradient = false}) {
    final minWidth = MediaQuery.of(context).size.width / 2 -
        Const.paddingHorizon -
        Const.paddingHorizon / 2;
    return GestureDetector(
      onTap: () {
        // if (onPress != null) {
        onPress!();
        // }
      },
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth),
        decoration: BoxDecoration(
            color: AppStyles.mainColor,
            borderRadius: BorderRadius.circular(30),
            gradient: isGradient ? AppStyles.gradient : null),
        height: ScreenUtil().setHeight(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: ScreenUtil().setHeight(size),
              width: ScreenUtil().setHeight(size),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              title,
              style: AppStyles.copyStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
