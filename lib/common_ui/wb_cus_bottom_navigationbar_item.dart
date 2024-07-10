import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class WbCusBottomNavigationBarItem extends BottomNavigationBarItem {
  WbCusBottomNavigationBarItem(
      {required String icon,
      required String activeIcon,
      String? label,
      required AnimationController controller})
      : super(
            icon: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 6),
              child: Lottie.asset(
                "assets/lottie/$icon.zip",
                width: 24,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 6),
              child: Lottie.asset("assets/lottie/$activeIcon.zip",
                  width: 24, controller: controller),
            ),
            label: label);
}
