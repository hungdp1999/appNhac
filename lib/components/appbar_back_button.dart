import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarBackButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const AppBarBackButton({super.key, 
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap ?? (){},
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(right: 10.w),
            child: SvgPicture.asset(
              AppIcons.icBack,
              width: 25,
              color: AppStyles.grey3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(
                  child: Text(
            title ?? '',
            style: AppStyles.largeTitleAppBar
          ),
        ),
      ],
    );
  }
}
