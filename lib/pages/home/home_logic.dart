
import 'package:demoflutter/pages/home/home_marquee_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import '../../pages.dart';
import 'home_list_model.dart';

class HomeLogic extends GetxController with StateMixin {
  late RefreshController refreshController;

  var homeListModel = HomeListModel().obs;
  var homeMarqueeString = HomeMarqueeModel().obs;
  var page = 1.obs;

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
      refreshController.refreshCompleted(resetFooterState: true);
      change(null, status: RxStatus.success()); //Rx通知
    });
    page.value = 1;
    Map<String, dynamic> param = {};
    param["num"] = 10;
    param["page"] = page.value;
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

  void loadMoreBanners() async {
    var nowpage = ++page.value;
    if (nowpage > homeListModel.value.allnum) {
      JWToastUtil.showToastCenter("无更多数据");
      refreshController.loadComplete();
      page.value = homeListModel.value.allnum;
      return;
    }
    Map<String, dynamic> param = {};
    param["num"] = 10;
    param["page"] = nowpage;
    // param["rand"] = "";
    // param["word"] = "";
    var bannerQuest =
        await JWAsyncHttpRequest().get(JWApi.bannerImg, queryParameters: param);
    if (null != bannerQuest) {
      var bean = HomeListModel.fromJson(bannerQuest.data);
      if (page.value <= bean.allnum) {
        homeListModel.value.allnum = bean.allnum;
        homeListModel.value.curpage = bean.curpage;
        for (var element in bean.newslist) {
          homeListModel.value.newslist.add(element);
        }
      }
    } else {
      JWToastUtil.showSuccessToast("list异常");
    }
    refreshController.loadComplete();
    refresh();
  }

  void onItemOnClick(int position){
    var newslist = homeListModel.value.newslist[position];
    JWToastUtil.showToastCenter(newslist.description.toString());
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
