import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demoflutter/common_ui/wb_cus_image_view.dart';
import 'package:demoflutter/common_ui/wb_scaffold.dart';
import 'package:flutter/widgets.dart';
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
      body: _getBodyView(),
    );
  }

  Widget _getBodyView() {
    // Obx(() {//加载更多时系统自动调用刷新
    //   return Container(
    //     child: SmartRefresher(
    //       controller: logic.refreshController,
    //       enablePullUp: true,
    //       enablePullDown: true,
    //       onRefresh: logic.refreshData,
    //       onLoading: logic.loadMoreBanners,
    //       header: CNHeader(),
    //       child: ListView(
    //         children: [
    //           _banner(),
    //           _marqueeText(),
    //           _getCenterText(),
    //         ],
    //       ),
    //     ),
    //   );
    // }),
    // return logic.obx(
    //   //加载更多需要在logic类中调用刷新
    //   (state) => SmartRefresher(
    //     controller: logic.refreshController,
    //     enablePullUp: true,
    //     enablePullDown: true,
    //     onRefresh: logic.refreshData,
    //     onLoading: logic.loadMoreBanners,
    //     header: CNHeader(),
    //     child: ListView(
    //       children: [
    //         _banner(),
    //         _marqueeText(),
    //         _getListView(),
    //       ],
    //     ),
    //   ),
    // );
    return logic.obx(
      //加载更多需要在logic类中调用刷新
      (state) => Column(
        children: [
          _banner(),
          _marqueeText(),
          Expanded(
            child: Scrollbar(
              child: SmartRefresher(
                controller: logic.refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: logic.refreshData,
                onLoading: logic.loadMoreBanners,
                header: CNHeader(),
                child: _getListView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 轮播图
  Widget _banner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      height: Get.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.transparent),
      child: Swiper(
        itemCount: logic.homeListModel.value.newslist.length,
        itemHeight: Get.width * 0.4,
        autoplay: true,
        pagination: SwiperPagination(
            builder: RectSwiperPaginationBuilder(
                color: textColor,
                activeColor: themeColor,
                size: const Size(6, 4),
                activeSize: const Size(10, 4))),
        itemBuilder: (context, index) {
          var model = logic.homeListModel.value.newslist[index];
          return GestureDetector(
            onTap: () {
              logic.launchURL(model.url.toString());
            },
            child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Colors.white),
      padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
      margin: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
      child: SSMarquee(
        child: Text(
          logic.homeMarqueeString.value.content ?? "",
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  ///list列表
  Widget _getListView() {
    return ListView.builder(
        // Scrollbar中不需要设置shrinkWrap/physics
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: logic.homeListModel.value.newslist.length,
        itemBuilder: (child, index) {
          return getItemView(index);
        });
  }

  Widget getItemView(int position) {
    return GestureDetector(
      onTap: () {
        logic.onItemOnClick(position);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(13, 6, 13, 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Text(
                  logic.homeListModel.value.newslist[position].source
                      .toString(),
                  style: const TextStyle(fontSize: 13),
                ),
                const Spacer(),
                Text(
                  logic.homeListModel.value.newslist[position].ctime.toString(),
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const Divider(
              height: 5,
            ),
            Row(
              children: [
                getStateTypeView(1, position),
                const SizedBox(
                  width: 5,
                ),
                getStateTypeView(2, position),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getStateTypeView(int type, int position) {
    if ((position % 2 == 0 && type == 1) || (position % 2 != 0 && type == 2)) {
      return WBCusImageView(
        icon: logic.homeListModel.value.newslist[position].picUrl.toString(),
        width: 120,
        height: 70,
      );
    } else {
      return Expanded(
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  logic.homeListModel.value.newslist[position].title.toString(),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  logic.homeListModel.value.newslist[position].description
                      .toString(),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
