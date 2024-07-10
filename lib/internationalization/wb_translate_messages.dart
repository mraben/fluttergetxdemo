import 'package:demoflutter/internationalization/chinese.dart';
import 'package:demoflutter/internationalization/english.dart';
import 'package:get/get.dart';

class WBTranslateMessages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en_US": English.values,
    "zh_CN": Chinese.values,
  };

}