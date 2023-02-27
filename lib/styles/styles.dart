import 'package:base_project/helper/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static const String font = 'ProductSans';

  static TextStyle copyStyle({
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    TextDecoration? decoration,
  }) =>
      TextStyle(
          fontFamily: font,
          fontSize: ScreenUtil().setSp(fontSize ?? 14),
          fontWeight: fontWeight,
          color: color ?? Const.colorText,
          decoration: decoration);

  static TextStyle titleAppbar = copyStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const Color mainColor = Color(0xffF95703);
  static const Color orange50 = Color(0xffFF8445);
  static const Color orange15 = Color(0xffFFF6F1);
  static const Color green = Color(0xff0EA226);
  static const Color green50 = Color(0xff33E950);
  static const Color green15 = Color(0xffE4FFE9);
  static const Color blue = Color(0xff2F97F7);
  static const Color yellow = Color(0xffF99603);
  static const Color yellow50 = Color(0xffFFC165);
  static const Color yellow15 = Color(0xffFFF9E9);
  static const Color grey = Color(0xff222323);
  static const Color grey1 = Color(0xff454545);
  static const Color grey2 = Color(0xff6C6C6C);
  static const Color grey3 = Color(0xffB1B1B1);
  static const Color grey4 = Color(0xffE4E4E4);
  static const Color grey5 = Color(0xffF7F7F7);
  static const Color grey7 = Color(0xffC4C4C4);
  static const LinearGradient gradient = LinearGradient(
    colors: [mainColor, yellow],
    stops: [0, 1],
    tileMode: TileMode.clamp,
  );

  static const LinearGradient unSelectDark = LinearGradient(
    colors: [grey1, grey1],
    stops: [1, 1],
    tileMode: TileMode.clamp,
  );

  static const LinearGradient unSelectLight = LinearGradient(
    colors: [Colors.white, Colors.white],
    stops: [1, 1],
    tileMode: TileMode.clamp,
  );

  static const Color white = Color(0xffFFFFFF);
  static const Color grey500 = Color(0xff7D7D86);
  static const Color black = Colors.black;
  static const Color purple = Color(0xff9A49B2);
  static const Color black12 = Color(0xff7D7D86);
  static const Color darkGrey = Color(0xffA9A8AE);
  static const Color red = Color(0xffE31818);

  static const double mainFontSize = 15;

  static TextStyle largeTitleAppBar = copyStyle(
    fontSize: 28,
    color: mainColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle mediumTitleAppBar = copyStyle(
    fontSize: 22,
    color: mainColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle labelStyle = copyStyle(
    fontSize: 22,
    color: grey,
    fontWeight: FontWeight.bold,
  );

  static EdgeInsets paddingTitle = const EdgeInsets.only(
    left: 15,
    top: 20,
    bottom: 10,
  );

  static TextStyle headline5(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    return Theme.of(context)
        .textTheme
        .headline5!
        .copyWith(fontSize: fontSize, fontWeight: fontWeight, fontFamily: font);
  }

  // grey4 - black
  static TextStyle title(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: font);
  }

  // grey3 - grey2
  static TextStyle subTitle(BuildContext context,
      {double? fontSize, Color? color}) {
    return Theme.of(context)
        .textTheme
        .subtitle2!
        .copyWith(color: color, fontSize: fontSize, fontFamily: font);
  }

  static TextStyle button(BuildContext context, {Color? color}) {
    return Theme.of(context)
        .textTheme
        .button!
        .copyWith(color: color, fontFamily: font);
  }

  static TextStyle header =
      copyStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor);
}
