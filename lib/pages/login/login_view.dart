import 'package:flutter/material.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:demoflutter/common_ui/login_text_field.dart';
import 'package:demoflutter/common_ui/theme_enter_btn.dart';
import 'package:demoflutter/common_ui/wb_scaffold.dart';
import 'package:demoflutter/internationalization/globalization.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();

  @override
  Widget build(BuildContext context) {
    return JWManager().isPhoneLogin ? _getPhoneView() : _getUserPaddView();
  }

  Widget _getPhoneView() {
    return WBScaffold(
        title: WBGlobalization.login.tr,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Text(
                WBGlobalization.phone.tr,
                style: WBFontStyle.copyWith(fontSize: 14.sp, color: textColor),
              ),
              const SizedBox(height: 10),
              LoginTextField(
                type: TextFieldWidgetType.phone,
                areaCode: "+86",
                selAreaCodeClick: logic.clickSelArea,
                placeHolder: WBGlobalization.inputPhone.tr,
                textInputType: TextInputType.number,
                onChanged: (str) {},
              ),
              const SizedBox(height: 10),
              Text(
                WBGlobalization.code.tr,
                style: WBFontStyle.copyWith(fontSize: 14.sp, color: textColor),
              ),
              const SizedBox(height: 10),
              LoginTextField(
                type: TextFieldWidgetType.code,
                placeHolder: WBGlobalization.inputCode.tr,
                textInputType: TextInputType.number,
                codebtnTitle: WBGlobalization.getCode.tr,
                sendCodeClick: logic.getCodeClick,
              ),
              const SizedBox(height: 20),
              ThemeEnterBtn(
                  title: WBGlobalization.login.tr,
                  height: 44,
                  onPressed: logic.clickLogin),
            ],
          ),
        ));
  }

  Widget _getUserPaddView() {
    return WBScaffold(
        title: WBGlobalization.login.tr,
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 40,left: 15,right: 15),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Text(
                WBGlobalization.account.tr,
                style: WBFontStyle.copyWith(fontSize: 14.sp, color: textColor),
              ),
              const SizedBox(height: 10),
              LoginTextField(
                controller: logic.accountController,
                type: TextFieldWidgetType.account,
                selAreaCodeClick: logic.clickAccount,
                placeHolder: WBGlobalization.inputAccount.tr,
                textInputType: TextInputType.text,
                onChanged: (str) {},
              ),
              const SizedBox(height: 10),
              Text(
                WBGlobalization.password.tr,
                style: WBFontStyle.copyWith(fontSize: 14.sp, color: textColor),
              ),
              const SizedBox(height: 10),
              LoginTextField(
                controller: logic.passWordController,
                type: TextFieldWidgetType.psw,
                selAreaCodeClick: logic.clickPassWord,
                placeHolder: WBGlobalization.inputPassword.tr,
                textInputType: TextInputType.text,
                onChanged: (str){},
              ),
              const SizedBox(height: 50),
              ThemeEnterBtn(
                  title: WBGlobalization.login.tr,
                  height: 44,
                  onPressed: logic.clickAccountPassWordToLogin),
            ],
          ),
        ));
  }
}
