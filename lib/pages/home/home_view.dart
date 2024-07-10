import 'package:demoflutter/internationalization/globalization.dart';
import 'package:flutter/material.dart';
import 'package:demoflutter/common_ui/wb_cus_image_view.dart';
import 'package:demoflutter/common_ui/wb_scaffold.dart';
import 'package:get/get.dart';
import '../../JWTools/jw_tools.dart';
import '../../r.dart';
import 'home_logic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          width: 30,
          height: 30,
          child: GestureDetector(
            onTap: logic.judgeLogin,
            child: SvgPicture.asset(
              R.assetsImageIconSvgGoogle,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: logic.clickNoti,
              icon: SvgPicture.asset(
                R.assetsImageRing,
              )),
        ],
      ),
      backgroundColor: viewbgColor,
      body: logic.obx(
        (state) => Container(
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: SmartRefresher(
            controller: logic.refreshController,
            onRefresh: logic.loadBanners,
            header: CNHeader(),
            child: ListView(
              children: [
                _banner(),
                _getCenterText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return Container(
      height: Get.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey),
      child: Swiper(
        itemCount: logic.homeBannerArray.length,
        itemHeight: Get.width * 0.4,
        autoplay: true,
        pagination: SwiperPagination(
            builder: RectSwiperPaginationBuilder(
                color: textColor,
                activeColor: themeColor,
                size: const Size(6, 4),
                activeSize: const Size(10, 4))),
        itemBuilder: (context, index) {
          var model = logic.homeBannerArray[index];
          return GestureDetector(
            onTap: () {
              logic.launchURL(model.url.toString());
            },
            child: Container(
                margin: const EdgeInsets.only(
                    left: 16, top: 12, right: 16, bottom: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: WBCusImageView(
                  icon: model.image.toString(),
                  fit: BoxFit.fill,
                )),
          );
        },
      ),
    );
  }

  Widget _getCenterText() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      alignment: Alignment.center,
      child: Text(WBGlobalization.home.tr),
    );
  }
}
