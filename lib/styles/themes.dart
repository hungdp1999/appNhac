import 'package:base_project/helper/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'styles.dart';

class MyTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: Const.colorPrimary,
    fontFamily: Const.fontSanfran,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: ScreenUtil().setHeight(10),
      ),
    ),
  );
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: Const.colorPrimary,
    fontFamily: Const.fontSanfran,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: ScreenUtil().setHeight(10),
      ),
    ),
  );

  static final ThemeData lightTheme2 = ThemeData(
    disabledColor: AppStyles.grey4,
    brightness: Brightness.light,
    hintColor: AppStyles.grey3,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppStyles.white,
      iconTheme: IconThemeData(color: AppStyles.black),
      actionsIconTheme: IconThemeData(color: AppStyles.black),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      secondary: Colors.red,
      brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 20,
        color: AppStyles.grey,
        fontWeight: FontWeight.normal,
      ),
      subtitle1: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 16,
        color: AppStyles.black,
        fontWeight: FontWeight.w600,
      ),
      subtitle2: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 13,
        color: AppStyles.grey2,
      ),
      bodyText2: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 16,
        color: AppStyles.grey,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
  static final ThemeData darkTheme2 = ThemeData(
    scaffoldBackgroundColor: AppStyles.grey,
    disabledColor: AppStyles.grey1,
    brightness: Brightness.dark,
    hintColor: AppStyles.grey3,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      secondary: Colors.red,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppStyles.grey,
      iconTheme: IconThemeData(color: AppStyles.red),
      actionsIconTheme: IconThemeData(color: AppStyles.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 20,
        color: AppStyles.white,
        fontWeight: FontWeight.normal,
      ),
      subtitle1: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 16,
        color: AppStyles.grey4,
        fontWeight: FontWeight.w600,
      ),
      subtitle2: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 13,
        color: AppStyles.grey3,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        fontFamily: AppStyles.font,
        fontSize: 16,
        color: AppStyles.grey4,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
