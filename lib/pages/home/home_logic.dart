import 'dart:ui';

import 'package:demoflutter/pages/home/home_marquee_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import '../../pages.dart';
import 'home_banner_model.dart';
import 'home_list_model.dart';
import 'home_marquee_model.dart';

class HomeLogic extends GetxController with StateMixin {
  late RefreshController refreshController;

  // final homeBannerArray = <HomeBannerModel>[].obs;
  final homeListModel = HomeListModel().obs;
  final homeMarqueeString = HomeMarqueeModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    refreshData();
  }

  void refreshData() {
    loadBanners();
    getMarqueeString();
  }

  void loadBanners() async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      refreshController.refreshCompleted();
      change(null, status: RxStatus.success()); //Rx通知
    });
    Map<String, dynamic> param = {};
    param["num"] = 10;
    param["page"] = 1;
    // param["rand"] = "";
    // param["word"] = "";
    var bannerQuest =
        await JWAsyncHttpRequest().get(JWApi.bannerImg, queryParameters: param);
    if (null != bannerQuest) {
      homeListModel.value = HomeListModel.fromJson(bannerQuest.data);
    } else {
      JWToastUtil.showSuccessToast("list异常");
    }
  }

  void judgeLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  void clickNoti() {
    JWToastUtil.showToastCenter("首页通知");
  }

  void launchURL(String string) {
    JWToastUtil.showToastCenter("调整Url$string");
  }

  void getMarqueeString() async {
    var quest = await JWAsyncHttpRequest().get(JWApi.marqueeString);
    if (null != quest.data) {
      homeMarqueeString.value = HomeMarqueeModel.fromJson(quest.data);
    } else {
      JWToastUtil.showSuccessToast("marquee异常");
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
