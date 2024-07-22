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
          child: SmartRefresher(
            controller: logic.refreshController,
            onRefresh: logic.refreshData,
            header: CNHeader(),
            child: ListView(
              children: [
                _banner(),
                _marqueeText(),
                _getCenterText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 轮播图
  Widget _banner() {
    return Container(
      margin: const EdgeInsets.all(15),
      height: Get.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.transparent),
      child: Swiper(
        itemCount: logic.homeListModel.value.newslist!.length,
        itemHeight: Get.width * 0.4,
        autoplay: true,
        pagination: SwiperPagination(
            builder: RectSwiperPaginationBuilder(
                color: textColor,
                activeColor: themeColor,
                size: const Size(6, 4),
                activeSize: const Size(10, 4))),
        itemBuilder: (context, index) {
          var model = logic.homeListModel.value.newslist![index];
          return GestureDetector(
            onTap: () {
              logic.launchURL(model.url.toString());
            },
            child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: WBCusImageView(
                  icon: model.picUrl.toString(),
                  fit: BoxFit.fill,
                )),
          );
        },
      ),
    );
  }

  /// 跑马灯
  Widget _marqueeText() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: SSMarquee(
        child: Text(logic.homeMarqueeString.value.content ?? ""),
      ),
    );
  }

  ///list列表
  Widget _getCenterText() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      alignment: Alignment.center,
      child: Text(WBGlobalization.home.tr),
    );
  }
}
