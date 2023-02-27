import 'package:http/http.dart' as http;

class SessionNetwork {
  static final SessionNetwork _singleton = SessionNetwork._internal();

  factory SessionNetwork() {
    return _singleton;
  }

  SessionNetwork._internal();
  static Map<String, String> sessionHeaders = {};

  static Future get(String? url) async {
    if (sessionHeaders.keys.isEmpty) {
      // setCookiesFromYtb(SharedPreHelper?.getCookies());
    }
    final response = await http.get(Uri(path: url), headers: sessionHeaders);
    updateCookie(response);
    return response.body;
  }

  static Future post(String url, {dynamic body}) async {
    if (sessionHeaders.keys.isEmpty) {
      // setCookiesFromYtb(SharedPreHelper?.getCookies());
    }
    http.Response response =
        await http.post(Uri(path: url), body: body, headers: sessionHeaders);
    updateCookie(response);
    return response.body;
  }

  static void updateCookie(http.Response response) {
    final rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final index = rawCookie.indexOf(';');
      final cookies = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      // SharedPreHelper?.saveCookies(cookies);
      sessionHeaders['cookie'] = cookies;
    }
  }

  // static setCookiesFromYtb(String cookies) {
  //   if (cookies != null) {
  //     // SharedPreHelper?.saveCookies(cookies);
  //     sessionHeaders['cookie'] = cookies;
  //   }
  // }
}
