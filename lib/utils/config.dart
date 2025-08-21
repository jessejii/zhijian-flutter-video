/*
 *
 *  * zhijian-flutter版
 *  * (c) 2021 - 2023 @尚真
 *  * www.wodecun.com
 *
 */

class Config {
  Config._();

  static const bool DEBUG = false;
  static const TOKEN_KEY = "token";
  static const KUSER = "localstoreuser"; //会员本地保存prefs key
  static const String WEB_URL = "http://www.wodecun.com/";
  static const String BASE_URL = "http://api.wodecun.com/";
  static const String? PROXY = null;
  static const String CONTENT_TYPE = 'application/json';
  static const String ERROR_IMAGE = "$WEB_URL/images/nopic.png";
  static const Map<String, dynamic> HEADER = {
    'X-Requested-With': 'XMLHttpRequest'
  };
  static const int CONNECT_TIMEOUT = 10000;
  static const int SEND_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 20000;
  static const String EMAIL = "jisjian@126.com";
  static const String ANDROID_APPID = "com.wode.zhijian";
  static const String IOS_APPID = "585027354";
}
