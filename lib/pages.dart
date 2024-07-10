import 'package:demoflutter/pages/login/login_binding.dart';
import 'package:demoflutter/pages/login/login_view.dart';
import 'package:demoflutter/pages/tab_bar/tab_bar_view.dart';
import 'package:get/get.dart';

part "./app_routes.dart";

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TABBAR,
      page: () => Tab_barPage(),
    ),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(),binding: LoginBinding()),
  ];
}


