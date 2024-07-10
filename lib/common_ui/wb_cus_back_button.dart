import 'package:flutter/material.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:demoflutter/pages.dart';
import 'package:get/get.dart';

class WBCusBackButton extends StatelessWidget {
  VoidCallback? onPressed;
  WBCusBackButton({Key? key,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios,color: themeColor,),
      onPressed: onPressed ?? () {
        print("last route:${Get.previousRoute}, current route:${Get.currentRoute}");
        if (Get.previousRoute.isNotEmpty) {
          // if (Get.previousRoute == Get.currentRoute) {
          //   Get.offAllNamed(Routes.TABBAR);
          // }else {
            Get.back();
          // }

        } else {
          Get.offAllNamed(Routes.TABBAR);
        }
      },
    );
  }
}

class WBRightArrow extends StatelessWidget {
  const WBRightArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/mine/enter_icon.webp",
      width: 6,
    );
  }
}

class WBServiceBtn extends StatelessWidget {
  const WBServiceBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          // launchKefu();
        },
        icon: Image.asset(
          "assets/mine/cus_service.png",
          width: 20,
        ));
  }
}
