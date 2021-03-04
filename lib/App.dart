import 'package:fluro/fluro.dart';

class App {
  static bool isDebug = true;

  static int appColor = 0xFFFFAC34;
  static FluroRouter router;
  static String imgControllerAli = "?x-oss-process=image/resize,h_400,w_400";

  static String token = "";
  static String token_mem = "";

  static const String DOMAIN_API = "https://api.xxx.com/";
  static const String DOMAIN_SHOP = "https://shop.xxx.com/";
  static const String DOMAIN_MEM = "https://mem.xxx.com/";
}
