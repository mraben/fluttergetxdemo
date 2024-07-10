import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import '../../pages.dart';
import 'home_banner_model.dart';

class HomeLogic extends GetxController with StateMixin {
  late RefreshController refreshController;
  final homeBannerArray = <HomeBannerModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    loadBanners();
  }

  void loadBanners() async{
    Future.delayed(const Duration(milliseconds: 3000), () {
      refreshController.refreshCompleted();
      change(null,status: RxStatus.success());//Rx通知
    });
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
