import 'package:flutter/material.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:demoflutter/common_ui/wb_cus_bottom_navigationbar_item.dart';
import 'package:demoflutter/internationalization/globalization.dart';
import 'package:demoflutter/pages/home/home_view.dart';
import 'package:demoflutter/pages/mine/mine_view.dart';
import 'package:demoflutter/pages/tab_bar/drag_move_box.dart';
import 'package:get/get.dart';
import 'tab_bar_logic.dart';
import 'package:demoflutter/r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tab_barPage extends StatelessWidget {
  Tab_barPage({Key? key}) : super(key: key);
  final logic = Get.put(Tab_barLogic());
  final List<Widget> _pages = [
    HomePage(),
    MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            Positioned.fill(child: TabBarView(children: _pages,
              controller: logic.tabController,
              physics: const NeverScrollableScrollPhysics(),
            )),
            Positioned(right: 15,
                bottom: Get.bottomBarHeight / Get.mediaQuery.devicePixelRatio + 15,
                child:
                Offstage(
                  offstage: !logic.hasNotify.value,
                  child: DragMoveBox(
                    child: ImageButton(
                      alignment: IconTextAlignment.iconTopTextBottom,
                      icon: Image.asset(
                        R.assetsImageIconGoogle, width: 30,),
                      label: Text("返回", style: WBFontStyle.copyWith(
                          color: themeColor, fontSize: 15.sp),),
                      onPressed: logic.toBack,
                    ),
                  ),
                )),
            Positioned(right: 15,
                bottom: Get.bottomBarHeight / Get.mediaQuery.devicePixelRatio +
                    60,
                child:
                Offstage(
                  offstage: !logic.hasMSg.value,
                  child: DragMoveBox(
                    child: InkWell(
                      onTap: logic.toMsg,
                      child: Badge(
                        label: const Text("1"),
                        child: Image.asset(R.assetsImageIconGoogle, width: 30,),
                      ),
                    ),
                  ),
                ))

          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: logic.selIndex.value,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: WBFontStyle.copyWith(
              fontSize: 12, fontWeight: FontWeight.w500, color: themeColor),
          unselectedLabelStyle: WBFontStyle.copyWith(fontSize: 11,
              fontWeight: FontWeight.w500,
              color: "#aab3bf".toColor()),
          onTap: logic.changeBottomIndex,
          items: [
            WbCusBottomNavigationBarItem(icon: "inactive_home",
                activeIcon: "active_home",
                label: WBGlobalization.home.tr,
                controller: logic.tabControllers[0]),
            WbCusBottomNavigationBarItem(icon: "inactive_account",
                activeIcon: "active_account",
                label: WBGlobalization.mine.tr,
                controller: logic.tabControllers[1]),

          ],
        );
      }),
    );
  }
}
