import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _gesPwdManagerStateKey = '_GesPwdManagerStateKey';
const String _gesPwdManagerOnKey = '_gesPwdManagerOnKey';
class GesPwdManager {
  static void savePwd(String text) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_gesPwdManagerStateKey+ (JWManager().SP_ID ?? ''), text);
    await saveOnPwd(true);
  }
  static Future<bool> verifyPwd(String text) async {
    if (text.isEmpty) {
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_gesPwdManagerStateKey + (JWManager().SP_ID ?? '')) == text;
  }
  static Future<bool> isExistPwd() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_gesPwdManagerStateKey+ (JWManager().SP_ID ?? ''))?.isNotEmpty ?? false;
  }

  static Future<bool> isOnPwd() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_gesPwdManagerOnKey+ (JWManager().SP_ID ?? '')) ?? false;
  }

  static Future<bool> saveOnPwd(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_gesPwdManagerOnKey+ (JWManager().SP_ID ?? ''),value);
  }
}