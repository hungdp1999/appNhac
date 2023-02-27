import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class RecentlyPlayedNoData extends StatelessWidget {
  final bool enableDarkMode;
  const RecentlyPlayedNoData({
    Key? key,  this.enableDarkMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final enableDarkMode = BlocProvider.of<AppCubit>(context).enableDarkMode;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('assets/images/logo.png'),
            width: ScreenUtil().setWidth(120),
            height: ScreenUtil().setHeight(120),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'welcome'.tr(),
              style: AppStyles.title(context, fontSize: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: enableDarkMode ? Colors.white12 : const Color(0xffF5F6F7),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: enableDarkMode
                        ? Colors.white24
                        : const Color(0xffE5E7EA),
                  ),
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                // BlocProvider.of<AppCubit>(context).jumpPageController.add(1);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppIcons.iSearch,
                    color: AppStyles.mainColor,
                    width: ScreenUtil().setWidth(20),
                    height: ScreenUtil().setHeight(20),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'searchForMusic'.tr(),
                    style: AppStyles.copyStyle(
                        fontSize: 15,
                        color: AppStyles.mainColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
