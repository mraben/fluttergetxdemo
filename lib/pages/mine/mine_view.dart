import 'package:demoflutter/internationalization/globalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:get/get.dart';
import '../../common_ui/wb_scaffold.dart';
import 'mine_logic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MinePage extends StatelessWidget {
  final logic = Get.put(MineLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(WBGlobalization.mine.tr),
      ),
      body: Obx(() {
        return Stack(
          children: [
            _getView(),
            _mainPage(),
          ],
        );
      }),
      backgroundColor: viewbgColor,
    );
  }

  Widget _getView() {
    return const Center(
      child: Text("我的"),
    );
  }

  Widget _mainPage() {
    return Positioned.fill(
      top: Get.statusBarHeight / Get.mediaQuery.devicePixelRatio + 10,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SmartRefresher(
          header: CNHeader(),
          controller: logic.refreshController,
          onRefresh: logic.requestInfo,
          child: ListView(
            children: [
              _getTextView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextView() {
    return Center(child: Text("测试${logic.mineStr.value}"));
  }
}
