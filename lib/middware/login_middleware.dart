
import '../JWTools/notifications.dart';
import 'package:demoflutter/pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  // TODO: implement priority
  int? get priority => -1;
  @override
  RouteSettings? redirect(String? route) {
    // TODO: implement redirect
    GetStorage box = GetStorage();
    if (box.read(TOKEN_KEY) != null) {
      return super.redirect(route);
    }else {
      return const RouteSettings(name: Routes.LOGIN);
    }


  }
}