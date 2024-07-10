import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';

import 'package:get/get.dart';
import '../r.dart';

enum TextFieldWidgetType { phone, code, psw, account, imgCode }

class LoginTextField extends StatefulWidget {
  TextFieldWidgetType type;
  bool? showRequire;
  bool? isRegister;
  EdgeInsets? margin;
  String? leftLogo;
  String placeHolder;
  String? codebtnTitle;
  String? areaCode;
  String? imgCodeStr;
  bool? enable;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  VoidCallback? sendCodeClick;
  VoidCallback? selAreaCodeClick;
  TextInputType? textInputType;

  LoginTextField(
      {Key? key,
        required this.type,
        this.leftLogo,
        required this.placeHolder,
        this.margin,
        this.controller,
        this.enable,
        this.showRequire,
        this.isRegister,
        this.onChanged,
        this.sendCodeClick,
        this.areaCode,
        this.imgCodeStr,
        this.selAreaCodeClick,
        this.textInputType,
        this.codebtnTitle})
      : super(key: key);

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool showSerc = false;

  @override
  Widget build(BuildContext context) {
    return _textFieldWidget(widget.leftLogo, widget.type, widget.placeHolder,
        widget.controller, widget.sendCodeClick);
  }

  Widget _textFieldWidget(
      String? leftLogo,
      TextFieldWidgetType type,
      String placeHolder,
      TextEditingController? controller,
      VoidCallback? sendCodeClick) {
    List<Widget> tfs = [];
    var width = Get.width -
        40 -
        (widget.margin?.left ?? 0.0) -
        (widget.margin?.right ?? 0.0);
    if (widget.showRequire == true) {
      tfs.add(Container(
        child: Text(
          "*",
          style: WBFontStyle.copyWith(color: redColor, fontSize: 20),
        ),
        width: 20,
      ));
      width = width - 20;
    } else {
      if (widget.isRegister == true) {
        tfs.add(Container(
          width: 20,
        ));
        width -= 20;
      }
    }

    if (leftLogo != null && leftLogo.isNotEmpty == true) {
      tfs.add(Image.asset(
        leftLogo,
        width: 24,
        height: 24,
      ));
      tfs.add(SizedBox(
        width: 15,
      ));
      width = width - 39;
    }
    if (type == TextFieldWidgetType.code) {
      width -= 90;
    }
    if (type == TextFieldWidgetType.imgCode) {
      width -= 130;
    }
    if (type == TextFieldWidgetType.account) {
      width -= 5;
    }
    if (type == TextFieldWidgetType.psw) {
      width -= 5;
    }
    if (type == TextFieldWidgetType.phone) {
      width -= 70;
      tfs.add(ImageButton(
          onPressed: widget.selAreaCodeClick ?? () {},
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
          ),
          alignment: IconTextAlignment.iconRightTextLeft,
          label: Text(
            widget.areaCode ?? "",
            style: WBFontStyle.copyWith(color: Colors.blue, fontSize: 14),
          )));
    }
    bool isPsw = type == TextFieldWidgetType.psw;
    tfs.add(Container(
      height: 45,
      margin: EdgeInsets.only(
          left: (leftLogo == null || leftLogo.isEmpty) &&
              (widget.areaCode == null)
              ? 15
              : 0),
      width: width,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        keyboardType: widget.textInputType,
        obscureText: type == TextFieldWidgetType.psw ? !showSerc : false,
        onChanged: widget.onChanged,
        readOnly: widget.enable == false,
        style: WBFontStyle.copyWith(color: Colors.black, fontSize: 18.sp),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: placeHolder,
          hintStyle: WBFontStyle.copyWith(
              color: themeColor1,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
          suffixIcon: isPsw
              ? IconButton(
            icon: Image.asset(
              showSerc ? R.assetsImageEyeOpen : R.assetsImageEyeClose,
              width: 16,
              height: 16,
            ),
            iconSize: 16,
            focusNode: FocusNode(skipTraversal: true),
            onPressed: () {
              if (isPsw) {
                setState(() {
                  showSerc = !showSerc;
                });
              } else {
                controller?.clear();
              }
            },
          )
              : null,
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          isCollapsed: true,
        ),
      ),
    ));
    if (type == TextFieldWidgetType.code) {
      var btn = Container(
        width: 80,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: themeColor),
        child: TextButton(
            onPressed: sendCodeClick,
            child: Text(
              widget.codebtnTitle ?? "获取验证码",
              style: WBFontStyle.copyWith(fontSize: 10, color: Colors.white),
            )),
      );
      tfs.add(btn);
    }
    if (type == TextFieldWidgetType.imgCode) {
      var btn = GestureDetector(
        onTap: sendCodeClick,
        child: Container(
          // width: 120,
          height: 40,
          child: (widget.imgCodeStr == null ||
              widget.imgCodeStr?.isEmpty == true)
              ? Text(
            "获取验证码",
            style:
            WBFontStyle.copyWith(fontSize: 12.sp, color: textColor3),
            textAlign: TextAlign.center,
          )
              : image(widget.imgCodeStr ?? ""),
        ),
      );
      tfs.add(btn);
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      margin: widget.margin,
      child:
      // Column(
      //   children: [
      //     Row(
      //       children: tfs,
      //     ),
      //     Divider(
      //       height: 1,
      //       color: lineColor,
      //     )
      //   ],
      // ),
      Row(
        children: tfs,
      ),
    );
  }

  Widget image(String thumbnail) {
    String placeholder =
        "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";
    if (thumbnail?.isEmpty ?? true)
      thumbnail = placeholder;
    else {
      if (thumbnail.length % 4 > 0) {
        thumbnail +=
            '=' * (4 - thumbnail.length % 4); // as suggested by Albert221
      }
    }
    final _byteImage = Base64Decoder().convert(thumbnail);
    Widget image = Image.memory(
      _byteImage,
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );
    return image;
  }
}
