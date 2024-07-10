import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';

class ThemeOuterBtn extends StatelessWidget {
  late String title;
  late double height;
  double? width;
  double? radius;
  final VoidCallback? onPressed;
  Color? borderColor;
  TextStyle? style;
  EdgeInsets? margin;
   ThemeOuterBtn({Key? key,
     required this.title,
     required this.height,
     required this.onPressed,
     this.radius,
     this.width,
     this.style,
     this.borderColor,
     this.margin = const EdgeInsets.fromLTRB(38, 0, 38, 0),}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? EdgeInsets.fromLTRB(38, 0, 38, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? height/2), border: Border.all(color: borderColor ?? themeColor,
            width: 0.5)),
        child: Text(
          title,
          style: style ?? WBFontStyle.copyWith(color: themeColor, fontSize: 18.8.sp),
        ),
      ),
    );
  }
}
