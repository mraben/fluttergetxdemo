library JWTools;
import 'dart:developer';
import 'package:common_utils/common_utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:extended_image/extended_image.dart' hide MultipartFile;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';

import 'package:card_swiper/card_swiper.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as ENC;
import 'dart:ui' as ui;
import 'dart:async';
import 'package:dio/dio.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:demoflutter/internationalization/globalization.dart';

import 'package:get_storage/get_storage.dart';
import 'package:event_bus/event_bus.dart';
import 'dart:math' hide log;

import 'package:flutter/foundation.dart' show kIsWeb ;
import 'package:get/get.dart' hide MultipartFile,Response,FormData;

import '../common_ui/theme_enter_btn.dart';
import '../common_ui/theme_outer_btn.dart';

import '../pages.dart';
import '../pages/bean/wb_config_model.dart';
import 'notifications.dart';
part 'tabIndicator/imageIndicator.dart';
part 'tabIndicator/tab_size_indicator.dart';
part 'android_back_totop/AndroidBackToTop.dart';
part 'jw_manager.dart';
part 'bottomSheet/jw_bottom_sheet.dart';
part 'bottomSheet/jw_action_sheet.dart';
part 'rulerPicker/ruler_picker.dart';
part 'hud/jw_loading_dialog.dart';
part 'screenFit/jw_screen_fit.dart';
part 'toast/jw_toast_util.dart';
part 'model/jw_base_model.dart';
part 'definColor/define_color.dart';
part 'stringExtension/jw_string_extension.dart';
part 'timepicker/jw_time_picker.dart';
part 'AESTool/AESTool.dart';

part 'waterRipple/jw_water_ripple.dart';
part 'customAlert/jw_custom_alert.dart';
part 'customAlert/jw_textfield_alert.dart';
part 'timer/timer_util.dart';
part 'NetWork/jw_net_work_util.dart';
part 'NetWork/jw_api.dart';
part 'NetWork/jw_async_http_request.dart';
part 'splash/splashPage.dart';
part 'utils/platform.dart';
part 'ImageButton/image_buttom.dart';

part 'marquee/ss_marque.dart';

var WBFontStyle = const TextStyle(
    fontFamily: "Demo Family WBFontStyle"
);
var statusBarOverlay = SystemUiOverlayStyle(
  //设置状态栏的背景颜色
  statusBarColor: themeColor,
  //状态栏的文字的颜色
  statusBarIconBrightness: Brightness.light,
);
