import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';

class ThemeEnterBtn extends StatelessWidget {
  late String title;
  late double height;
  final VoidCallback? onPressed;
  Color? bgColor;
  double? width;
  double? radius;
  EdgeInsets? margin;
  TextStyle? style;
  ThemeEnterBtn({
    Key? key,
    required this.title,
    required this.height,
    required this.onPressed,
    this.style,
    this.bgColor,
    this.width,
    this.radius,
    this.margin = const EdgeInsets.fromLTRB(15, 0, 15, 0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? const EdgeInsets.fromLTRB(15, 0, 15, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? height/2), color: bgColor ??
            themeColor),
        child: Text(
          title,
          style:style ?? WBFontStyle.copyWith(color: Colors.white, fontSize: 18.8.sp),
        ),
      ),
    );
  }
}
