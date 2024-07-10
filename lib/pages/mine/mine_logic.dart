import 'dart:math';

import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineLogic extends GetxController {
  late RefreshController refreshController;

  var mineStr = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    // eventBus.fire("String");//发送消息
    eventBus.on<String>().listen((event) {//接收消息
      refreshController.requestRefresh();
    });
    requestInfo();
  }

  void  requestInfo() async{
    Future.delayed(const Duration(milliseconds: 3000),(){
      var x = Random().nextInt(100);
      mineStr.value = x.toString();
      refreshController.refreshCompleted();
    });
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
