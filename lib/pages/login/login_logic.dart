import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../JWTools/jw_tools.dart';
import 'package:get_storage/get_storage.dart';
import '../../JWTools/notifications.dart';
import '../../internationalization/globalization.dart';
import '../../pages.dart';

class LoginLogic extends GetxController {

  TextEditingController accountController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  void clickSelArea() {

  }
  void getCodeClick() {

  }
  void clickLogin() {

  }

  void clickAccount() {

  }

  void clickPassWord() {}

  void clickAccountPassWordToLogin() async {
    var account = accountController.text.toString();
    var password = passWordController.text.toString();
    if (account.isNotEmpty && password.isNotEmpty) {
      Map<String, String> map = HashMap();
      map["username"] = account;
      map["password"] = password;
      var resp = await JWAsyncHttpRequest().post(JWApi.login, showHud: true, data: map);
      if (resp.isOK) {
        var data = resp.data["token"];
        GetStorage().write(TOKEN_KEY, data);
        JWManager().token = data.toString();
        GetStorage().save();
        Get.offAllNamed(Routes.TABBAR);
      } else {
        JWToastUtil.showToastCenter("${resp.message}");
      }
    } else {
      JWToastUtil.showToastCenter(WBGlobalization.check_input.tr);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
