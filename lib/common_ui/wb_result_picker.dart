import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demoflutter/internationalization/globalization.dart';

import '../JWTools/jw_tools.dart';
import 'package:get/get.dart';

class WBResultPicker extends StatefulWidget {
  List<String> results;
  ValueChanged<int>? indexBlock;
  String? title;
   WBResultPicker({super.key,required this.results,this.indexBlock,this.title});

  @override
  State<WBResultPicker> createState() => _WBResultPickerState();
  static void showResultPicker({required List<String> results,ValueChanged<int>? indexBlock,String? title}) {
    showBottomSheetWindow(context: Get.context!, emptyDismissable: true,
        windowBuilder: (BuildContext con, Animation<double> animation,
            Animation<double> secondrayAnimation) {
          var tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
          return SlideTransition(
              position: animation.drive(tween),
              child: WBResultPicker(results: results,indexBlock: indexBlock,title: title,));
        });
  }

}

class _WBResultPickerState extends State<WBResultPicker> {
  int? selIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white),
      child: Column(
        children: [
          _bottomBtns(),
          _getPicker(),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _bottomBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 60,
          height: 40,
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              WBGlobalization.cancel.tr,
              style: WBFontStyle.copyWith(
                  fontSize: 16, color: textColor2,),
            ),
          ),
        ),
        Text(widget.title ?? "",style: WBFontStyle.copyWith(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w500),),
        SizedBox(
          width: 60,
          height: 40,
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            ),
            onPressed: () {
              if (selIndex != null) {
                widget.indexBlock?.call(selIndex!);
              }
              Navigator.pop(context);
            },
            child: Text(
              WBGlobalization.enter.tr,
              style: WBFontStyle.copyWith(
                  fontSize: 16,
                  color: themeColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
  Widget _getPicker() {
    return Container(
      height: 210,
      child: CupertinoPicker(
        itemExtent: 44,
        onSelectedItemChanged: (int value) {
          selIndex = value;
        },
        selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          background: unselbtnColor.withOpacity(0.4),
        ),
        children: widget.results.map((e) => Container(height: 44,alignment: Alignment.center,
            child: Text(e,style: WBFontStyle.copyWith(color: textColor3,fontSize: 14.sp),))).toList(),

      )
    );
  }
}
