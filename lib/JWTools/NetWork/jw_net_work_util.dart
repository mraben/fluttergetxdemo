part of JWTools;

enum JWNetWorkType { mobile, wifi ,none}

class JWNetWorkUtil {
  static Future<bool> isNetWorkAvailable() async {
    try {
      final result = await InternetAddress.lookup("baidu.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      print("network error.");
      return false;
    }
  }

  static Future<JWNetWorkType> netWorkType() async {
    var result = await(Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile) {
      return JWNetWorkType.mobile;
    }else if (result == ConnectivityResult.wifi) {
      return JWNetWorkType.wifi;
    }else {
      return JWNetWorkType.none; //未连接
    }
  }
}
