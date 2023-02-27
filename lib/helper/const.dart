import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Const {
  static const String secretKey = 'OJoirofre34924wierhjkf';
  static const String infoApi = isDebug
      ? 'https://stg-listenit.famtechvn.com/api'
      : 'https://api-listenit.famtechvn.com';

  static const String urlPolicy =
      'https://sites.google.com/view/listenitapp/home?authuser=1';
  static const String emailFeedback = 'example@example.com';
  static const String urlRateApp = '';
  static List<String> rapidKeys = [
    '67f98461fbmsh4de5b3059f8e78ep198ff4jsn20051f7463fa'
  ];
  static const String apiGoogleKey = 'AIzaSyDZlGlDgagXoYc6KpQ8_g_CnpltkBBaCu0';

  ///
  ///define configs
  ///
  static const double paddingHorizon = 10.0;
  static const int maxTimeResend = 120;
  static final double minHeightPlayer = ScreenUtil().setHeight(55.0);
  static const String nameFavourite = 'Favourite Songs';
  static const String nameLibrary = 'Library';

  ///
  ///in_app item
  ///
  static const String inapp3month = 'vn.famtech.listenit.autorenew3months';
  static const String inappYearly = 'vn.famtech.listenit.autorenewyearly';
  static const String inappLifetime = 'vn.famtech.listenit.lifetime';

  ///
  ///define fonts
  ///
  static const String fontSanfran = 'San Francisco';

  ///
  ///ads
  ///

  // static final String adsInterstitial = isDebug
  //     ? InterstitialAd.testAdUnitId
  //     : Platform.isIOS
  //         ? '/112517806/34913331623991256'
  //         : '/112517806/35469721623991267';
  // static final String adsBanner = isDebug
  //     ? BannerAd.testAdUnitId
  //     : Platform.isIOS
  //         ? '/112517806/12469791623991221'
  //         : '/112517806/13404431623991237';
  // static final String adsNative = isDebug
  //     ? NativeAd.testAdUnitId
  //     : Platform.isIOS
  //         ? '/112517806/57583621623991337'
  //         : '/112517806/56359271623991351';

  ///
  /// define colors
  ///
  static const Color colorLogo = Color(0xff00FDFF);
  static const Color colorPrimary = Color(0xff007AFF);
  static const Color colorBackground = Color(0xff002956);
  static const Color colorBackground1 = Color(0xff00101C);
  static const Color colorBottomBar = Color(0xff001826);
  static const Color colorBorder = Color(0xffD1D5DB);
  static const Color colorText = Color(0xffffffff);
  static const Color colorSubtext = Color(0xff828282);
  static const Color colorCheckbox = Color(0xffDADADA);
  static const Color colorButton = Color(0xffFFC107);
  static const Color colorTextButton = Color(0xffA07800);
  static const Color colorBgProgress = Color(0xff4F4F4F);
  static const Color colorBgCell = Color(0xff001826);
  static const Color colorBgPopupMenu = Color(0xff002956);
  static const Color colorBgIcon1 = Color(0xff002F5F);
  static const Color colorBgIcon2 = Color(0xff27AE60);
  static const Color colorBgIcon3 = Color(0xffEF2828);
  static const Color colorOrange = Color(0xffF2994A);

  static const bool isDebug = true;
}
