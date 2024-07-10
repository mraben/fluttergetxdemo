part of JWTools;

String aesKey = "xxxxx";
String md5Key = "xxxxx";
class AESTools {
  static String decryptString(String str) {
    try {
      final key = ENC.Key.fromUtf8(aesKey); //加密key
      final iv = ENC.IV.fromLength(0);
      debugPrint("beforeString: ${str}");
      final encrypter = ENC.Encrypter(ENC.AES(key, mode: ENC.AESMode.ecb));

      String decrypted = encrypter.decrypt64(str.trim().replaceAll("\r", "").replaceAll("\n", ""),iv: iv);

      debugPrint("decrypt string:${decrypted}");
      return decrypted;
    } catch (error) {
      debugPrint("decrypt err:${error}");
      return str;
    }
  }
  static String encryptString(String str) {

try {
  final key = ENC.Key.fromUtf8(aesKey);//加密key
  final encrypter = ENC.Encrypter(ENC.AES(key, mode: ENC.AESMode.ecb));
  final encryptStr = encrypter.encrypt(str);
  // print("encrypt strsss:${encryptStr.base64}");
  return encryptStr.base64;
}catch (error) {
  debugPrint("encrypt err:${error}");
  return str;
}

  }
  static String getLanguageText(String str) {
    try {
      Map<String,dynamic> json = jsonDecode(str);

      return json["original"] ?? (json["zh"] ?? (json.values.first ?? str));
    } catch (error) {
      print("json error:${error}");
      var tempStr = str;
      if (str.startsWith("{\"original\":\"")) {
       tempStr = str.replaceAll("{\"original\":\"", "");
       tempStr = tempStr.replaceAll("\"}", "");
      }
      return tempStr;
    }
  }
}
