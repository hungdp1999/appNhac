import 'dart:convert';
import 'dart:io';
import 'package:base_project/helper/aes_crypto/cryptojs_aes_encryption_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'const.dart';

class Utils {
  static double paddingAds(double widthDevice) {
    final phone = isDevicePhone();

    if (Platform.isIOS) {
      return phone ? (widthDevice - 320) / 2 : (widthDevice - 480) / 2;
    } else {
      return 0;
    }
  }

  static bool isDevicePhone() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600;
  }

  static escape(String? badString) {
    if (badString == null) {
      return null;
    }

    return badString
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '\"')
        .replaceAll('&apos;', "'")
        .replaceAll('&gt;', '>')
        .replaceAll('&lt;', '<')
        .replaceAll('&#39;', "'");
  }

  static Future navigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static void showToast(String title) {
    // Fluttertoast.showToast(
    //     msg: title,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     backgroundColor: Colors.black.withOpacity(0.5),
    //     textColor: Colors.white,
    //     fontSize: 16);
  }

  static Future showToastWarning(String content) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return showToast(content);
  }

  static void showToastLong(String title) {
    // Fluttertoast.showToast(
    //     msg: title,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.CENTER,
    //     backgroundColor: Colors.black.withOpacity(0.5),
    //     textColor: Colors.white,
    //     fontSize: 16);
  }

  static String formatDateFull(DateTime? date) {
    if (date == null) return '';
    final inputFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    return inputFormat.format(date);
  }

  static String formatDuration(Duration? duration) {
    if (duration == null) return '00:00';

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours <= 0) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static void copyToClipboard(String text) {
    if (text.isNotEmpty) {
      // Clipboard.setData(ClipboardData(text: text));
      // Utils.showToast('Copied');
    }
  }

  static dynamic decryptAESCrypto(String data) {
    final textPlain = decryptAESCryptoJS(data, Const.secretKey);
    return json.decode(textPlain);
  }

  static String removeSpecialSymbols(String text) {
    if (text == null) return '';
    return text.replaceAll(RegExp(r"[^\s\w]"), '');
  }

  static Future launchURL(String url) async {
    // if (url == null || url.isEmpty) {
    //   return;
    // }

    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   debugPrint('There was an error');
    // }
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String k_m_b_generator(String number) {
    final _num = int.parse(number);
    if (_num > 999 && _num < 99999) {
      return "${(_num / 1000).toStringAsFixed(1)} K";
    } else if (_num > 99999 && _num < 999999) {
      return "${(_num / 1000).toStringAsFixed(0)} K";
    } else if (_num > 999999 && _num < 999999999) {
      return "${(_num / 1000000).toStringAsFixed(1)} M";
    } else if (_num > 999999999) {
      return "${(_num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return _num.toString();
    }
  }

  static bool invalidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isShowAdAtIndex(int index) {
    if ((index != 0 && index == 3) || (index != 0 && (index + 4) % 7 == 0)) {
      return true;
    }
    return false;
  }

  // static void share(String content) {
  //   Share.share(content).catchError((e) {
  //     Utils.showToast(LocaleKeys.error.tr());
  //   });
  // }
}
