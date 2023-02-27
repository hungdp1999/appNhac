import 'package:flutter/material.dart';

import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderMore extends StatelessWidget {
  final String? title;
  final VoidCallback? onSeeMore;
  const HeaderMore({
    super.key,
    this.title,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Const.paddingHorizon.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: AppStyles.copyStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppStyles.mainColor),
          ),
          if (onSeeMore != null)
            InkWell(
              onTap: onSeeMore,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'seeMore'.tr(),
                  style: AppStyles.copyStyle(
                      fontSize: 14.sp, color: AppStyles.mainColor),
                ),
              ),
            )
        ],
      ),
    );
  }
}
