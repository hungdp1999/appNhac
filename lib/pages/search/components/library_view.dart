import 'package:flutter/material.dart';

import 'package:base_project/components/header_view.dart';
import 'package:base_project/helper/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        const HeaderView(
          title: 'Library',
        ),
        InkWell(
          onTap: () async {
            // await BlocProvider.of<PlaylistCubit>(context).getSongsLibrary();
            // Utils.navigatePage(context, const DetailLibraryView());
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(Const.paddingHorizon),
              right: ScreenUtil().setWidth(Const.paddingHorizon),
              top: ScreenUtil().setHeight(13),
              bottom: ScreenUtil().setHeight(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                // AppImages.bg_library,
                'AppImages.bg_library',
                width: double.infinity,
                height: ScreenUtil().setHeight(230),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
