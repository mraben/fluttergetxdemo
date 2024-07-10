import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demoflutter/common_ui/wb_cus_back_button.dart';
import '../JWTools/jw_tools.dart';
import 'package:universal_html/html.dart' as html;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WBScaffold extends Scaffold {
  WBScaffold({
    super.key,
    required Widget body,
    Color? backgroundColor,
    Color? barBackGroungColor,
    String? title,
    Widget? leading,
    List<Widget>? actions,
  }) : super(
          backgroundColor: backgroundColor ?? viewbgColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: leading ?? WBCusBackButton(),
            backgroundColor: barBackGroungColor ?? Colors.white,
            systemOverlayStyle: statusBarOverlay,
            title: Text(title ?? ""),
            actions: actions,
          ),
          body: (PlatformUtils().isWeb &&
                  (html.window.navigator.userAgent.contains('iPhone') ||
                      html.window.navigator.userAgent.contains('iPad') ||
                      html.window.navigator.userAgent.contains('iPod')))
              ? WillPopScope(child: body, onWillPop: () async => false)
              : body,
        );
}

Widget CNHeader() {
  return const ClassicHeader(
    refreshingText: "",
    releaseText: "",
    idleText: "",
    completeText: "",
  );
}

Widget CNFooter() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text("上拉加载");
      } else if (mode == LoadStatus.loading) {
        body = const CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = const Text("加载失败,点击重试");
      } else if (mode == LoadStatus.canLoading) {
        body = const Text("松手加载更多");
      } else {
        body = const Text("暂无更多数据");
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}
