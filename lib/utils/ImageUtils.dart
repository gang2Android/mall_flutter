import 'package:flutter_app_01/App.dart';

class ImageUtils {
  static String handleUrl(String imgUrl) {
    if (imgUrl.contains("x-oss-process")) {
      return imgUrl;
    }
    return imgUrl + App.imgControllerAli;
  }
}
