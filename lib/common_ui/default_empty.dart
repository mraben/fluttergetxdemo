import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultEmptyWidget extends StatefulWidget {
  var text;
  DefaultEmptyWidget({super.key,this.text = ''});

  @override
  State<DefaultEmptyWidget> createState() => _DefaultEmptyWidgetState();
}

class _DefaultEmptyWidgetState extends State<DefaultEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: Get.width,
      child: Column(
        children: [
          Image.asset('assets/image/empty.png',width: Get.width * 0.5,height: Get.width * 0.5,),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              widget.text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );;
  }
}
