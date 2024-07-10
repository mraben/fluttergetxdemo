part of JWTools;

class JWAsyncHttpRequest {
  static final JWAsyncHttpRequest _shared = JWAsyncHttpRequest._internal();

  factory JWAsyncHttpRequest() => _shared;
  Dio? dio;
  static const int connectTime = 60000;
  static const int receiveTime = 60000;
  static const String methodGet = "GET";
  static const String methodPost = "POST";
  static const String netErrorInfo = "网络连接失败,请检查网络";

  JWAsyncHttpRequest._internal() {
    if (dio == null) {
      if (PlatformUtils().isWeb) {
        BaseOptions options = BaseOptions(
          baseUrl: JWApi.baseUrl,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
          receiveDataWhenStatusError: false,
          connectTimeout: const Duration(milliseconds: connectTime),
          receiveTimeout: const Duration(milliseconds: receiveTime),
        );
        dio = Dio(options);
        dio?.interceptors.add(LogInterceptors());
      }
    }
  }

  Future<JWBaseModel> get(String url,
      {showHud,
      showErrToast,
      queryParameters,
      bool agreeService = true}) async {
    return _httpRequest(url,
        showHud: showHud ?? false,
        showErrToast: showErrToast ?? true,
        queryParameters: queryParameters,
        method: methodGet,
        agreeService: agreeService);
  }

  Future<JWBaseModel> post(String url,
      {showHud,
      showErrToast,
      queryParameters,
      Map<String, dynamic>? data}) async {
    return _httpRequest(
      url,
      showHud: showHud ?? false,
      showErrToast: showErrToast ?? true,
      queryParameters: queryParameters,
      data: data,
      method: methodPost,
    );
  }

  ///web端传bytes
  Future<JWBaseModel> upload({
    required String url,
    String? path,
    File? file,
    Uint8List? bytes,
    Map<String, dynamic>? dic,
  }) async {
    var res = JWBaseModel();
    var map = <String, dynamic>{};

    if (kIsWeb) {
    } else {
      if (Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        dio?.options.headers["Accept-platform"] = "android";
        dio?.options.headers["User-Agent"] = androidInfo.model;
      }
      if (Platform.isIOS) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        debugPrint('Running on ${iosInfo.utsname.machine}');
        dio?.options.headers["Accept-platform"] = "ios";
        dio?.options.headers["User-Agent"] = iosInfo.utsname.machine;
      }
      if (Platform.isWindows) {
        dio?.options.headers["Accept-platform"] = "win";
      }
      if (Platform.isMacOS) {
        dio?.options.headers["Accept-platform"] = "win";
      }
    }
    dio?.options.headers["Accept-version"] = 1;
    dio?.options.headers["Accept-language"] = JWManager().language ?? "zh";
    dio?.options.contentType = "application/x-www-form-urlencoded;"
        "charset=utf-8;multipart/form-data";
    if (kIsWeb) {
      map['receipt_img'] = MultipartFile.fromBytes(List<int>.from(bytes!));
    } else {
      if (path != null) {
        map['receipt_img'] = await MultipartFile.fromFile(path);
      }
      if (file != null) {
        map['receipt_img'] = await MultipartFile.fromFile(file.path);
      }
    }

    print(map);

    var formData = FormData.fromMap(map);

    try {
      var response = await dio!.post(url, data: formData, queryParameters: dic,
          onSendProgress: (int sent, int total) {
        debugPrint('$sent - $total');
        EasyLoading.showProgress(double.parse((sent / total).toString()));
        if (sent == total) {
          EasyLoading.dismiss();
        }
      });
      if (response.statusCode == HttpStatus.ok) {
        if (response.data == null || response.data == 'null') {
          log("返回数据null");
          res.code = 500;
          res.message = "返回数据null";
          return res;
        } else {
          Map<String, dynamic> data = jsonDecode(response.data);
          if (data is Map) {
            var model = JWBaseModel.fromJson(data);
            return model;
          } else {
            res.code = 500;
            res.message = "返回数据不是json类型";
            debugPrint("❌返回数据不是json类型：${response.data}");
            return res;
          }
        }
      }
      res.code = response.statusCode;
      res.message = response.statusMessage;
      return res;
    } on DioError catch (e) {
      debugPrint("请求错误:${e.toString()}");
      res.code = 500;
      res.message = e.toString();
      Get.back();
      return res;
    }
  }

  ///web端传bytes 视频上传单独处理，因为地址变成动态了
  Future<JWBaseModel> uploadVideo({
    required String url,
    String? path,
    File? file,
    Uint8List? bytes,
    Map<String, dynamic>? dic,
  }) async {
    var res = JWBaseModel();
    var map = <String, dynamic>{};
    BaseOptions options = BaseOptions(
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.plain,
      receiveDataWhenStatusError: false,
      connectTimeout: const Duration(milliseconds: connectTime),
      receiveTimeout: const Duration(milliseconds: receiveTime),
    );
    var videoDio = Dio(options);

    videoDio.interceptors.add(LogInterceptors());

    if (kIsWeb) {
    } else {
      if (Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        videoDio.options.headers["Accept-platform"] = "android";
        videoDio.options.headers["User-Agent"] = androidInfo.model;
      }
      if (Platform.isIOS) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        debugPrint('Running on ${iosInfo.utsname.machine}');
        videoDio.options.headers["Accept-platform"] = "ios";
        videoDio.options.headers["User-Agent"] = iosInfo.utsname.machine;
      }
      if (Platform.isWindows) {
        videoDio.options.headers["Accept-platform"] = "win";
      }
      if (Platform.isMacOS) {
        videoDio.options.headers["Accept-platform"] = "win";
      }
    }
    videoDio.options.headers["Accept-version"] = 1;
    videoDio.options.headers["Accept-language"] = JWManager().language ?? "zh";
    videoDio.options.contentType = "application/x-www-form-urlencoded;"
        "charset=utf-8;multipart/form-data";
    if (kIsWeb) {
      map['file_name'] = MultipartFile.fromBytes(List<int>.from(bytes!));
    } else {
      if (path != null) {
        map['file_name'] = await MultipartFile.fromFile(path);
      }
      if (file != null) {
        map['file_name'] = await MultipartFile.fromFile(file.path);
      }
    }

    print(map);

    var formData = FormData.fromMap(map);

    try {
      var response = await videoDio!.post(url,
          data: formData,
          queryParameters: dic, onSendProgress: (int sent, int total) {
        debugPrint('$sent - $total');
        EasyLoading.showProgress(double.parse((sent / total).toString()));
        // controller.progress.value = double.parse((sent / total).toString());
        if (sent == total) {
          // Get.back();
          // controller.progress.value = 0;
          EasyLoading.dismiss();
        }
      });
      if (response.statusCode == HttpStatus.ok) {
        if (response.data == null || response.data == 'null') {
          log("返回数据null");
          res.code = 500;
          res.message = "返回数据null";
          return res;
        } else {
          Map<String, dynamic> data = jsonDecode(response.data);
          if (data is Map) {
            var model = JWBaseModel.fromJson(data);
            return model;
          } else {
            res.code = 500;
            res.message = "返回数据不是json类型";
            debugPrint("❌返回数据不是json类型：${response.data}");
            return res;
          }
        }
      }
      res.code = response.statusCode;
      res.message = response.statusMessage;
      return res;
    } on DioError catch (e) {
      debugPrint("请求错误:${e.toString()}");
      res.code = 500;
      res.message = e.toString();
      Get.back();
      return res;
    }
  }

  Future<JWBaseModel> _httpRequest(String url,
      {bool showHud = false,
      bool showErrToast = true,
      Map<String, dynamic>? queryParameters,
      data,
      method,
      bool agreeService = true}) async {
    var res = JWBaseModel();
    if (dio == null) {
      res.code == 444;
      res.message = "S3地址未初始化";
      return res;
    }
    if (showHud == true) {
      EasyLoading.show(status: WBGlobalization.loading.tr);
    }
    // if (await JWNetWorkUtil.isNetWorkAvailable() == false) {
    //   if (showErrToast == true) {
    //     EasyLoading.showToast(netErrorInfo);
    //   }
    //
    //   if (showHud == true) {
    //     EasyLoading.dismiss();
    //   }
    //   res.code = 500;
    //   res.message = netErrorInfo;
    //   return res;
    // }
    String loginFrom = "";
    String phoneModel = "";
    if (kIsWeb) {
      loginFrom = "2";
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      WebBrowserInfo webinfo = await deviceInfo.webBrowserInfo;
      phoneModel = webinfo.browserName.toString() + (webinfo.userAgent ?? "");
    } else {
      if (Platform.isAndroid && agreeService) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        dio?.options.headers["Accept-platform"] = "android";
        dio?.options.headers["User-Agent"] = "Wapaka";
        loginFrom = "4";
        phoneModel = androidInfo.brand + (androidInfo.version.baseOS ?? "");
      }
      if (Platform.isIOS && agreeService) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        loginFrom = "3";
        debugPrint('Running on ${iosInfo.utsname.machine}');
        dio?.options.headers["Accept-platform"] = "ios";
        dio?.options.headers["User-Agent"] = iosInfo.utsname.machine;
        phoneModel = iosInfo.utsname.machine;
      }
      if (Platform.isWindows) {
        dio?.options.headers["Accept-platform"] = "win";
        loginFrom = "1";
      }
      if (Platform.isMacOS) {
        dio?.options.headers["Accept-platform"] = "win";
        loginFrom = "1";
      }
    }

    // dio?.options.headers["accept-version"] = "1.0";
    dio?.options.headers["Accept-language"] = JWManager().language ?? "zh-Hans";
    dio?.options.contentType = "application/x-www-form-urlencoded";
    if (JWManager().token != null && JWManager().token?.isNotEmpty == true) {
      dio?.options.headers["Authorization"] =
          "Bearer ${JWManager().token ?? ""}";
    }
    try {
      Map<String, dynamic>? dic = data ?? {};
      // if (url == JWApi.login || url == JWApi.register || url == JWApi.globalConfig || url == JWApi.getShareCode) {
      //   dic?["language"] = JWManager().language ?? "0";
      //   dic?["version"] = "63154009eb3fc249d0dddf113641a508b488ea7c";
      //   dic?["phone_model"] = phone_model;
      //   dic?["loginFrom"] = loginFrom;
      // }
      // if (JWManager().isLogined) {
      //   dic?["token"] = JWManager().token;
      // }

      var str = jsonEncode(dic);
      if (url == JWApi.testGuoLuApi) {
      } else {
        var md5Str = keyToMd5((str + md5Key));
        dic = {
          "Param": AESTools.encryptString(str),
          // "Autograph":md5Str
        };
      }

      Response response = await dio!.request(
        url,
        queryParameters: queryParameters,
        data: dic,
        options: Options(method: method),
      );
      if (showHud == true) {
        // JWLoadingDialog.hideHud();
        EasyLoading.dismiss();
      }
      if (response.statusCode == HttpStatus.ok) {
        if (response.data == null || response.data == 'null') {
          res.code = 0;
          res.message = "返回数据null";
          return res;
        } else {
          dynamic data = jsonDecode(response.data);

          if (data is Map) {
            var model = JWBaseModel.fromJson(data as Map<String, dynamic>);
            if (model.code == -1) {
              JWManager().logout();
            }

            if ((!model.isOK) && showErrToast == true) {
              var str = model.message;
              if (model.message != null && str?.isNotEmpty == true) {
                JWToastUtil.showToastCenter(str!);
              }
              // JWToastUtil.showToastCenter(str!);
              // SmartDialog.showToast(str!);
            }
            return model;
          } else {
            debugPrint("❌返回数据不是json类型：${data}");
            res.code = 500;
            res.message = "返回数据不是json类型";
            if (showErrToast) {
              JWToastUtil.showToastCenter(res.message ?? "");
            }
            return res;
          }
        }
      }
      res.code = response.statusCode;
      res.message = response.statusMessage;
      return res;
    } on DioError catch (e) {
      if (showHud == true) {
        EasyLoading.dismiss();
      }
      debugPrint("请求错误:${e.toString()}");
      res.code = 500;
      res.message = e.toString();
      return res;
    }
  }
}

//日志拦截器
class LogInterceptors extends InterceptorsWrapper {
  static JsonEncoder encode = const JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    debugPrint("*************请求开始****************");
    debugPrint("请求地址url:【${options.baseUrl}${options.path}】\n"
        "请求头headers:【${options.headers.toString()}】\n"
        "请求参数queryParam:【${options.queryParameters.toString()}】\n"
        "请求参数data：【${options.data.toString()}】");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    debugPrint("************✅*请求响应*✅***************${response.realUri.path}");
    debugPrint("返回状态码:【${response.statusCode}】\n"
        "返回statusMessage:【${response.statusMessage}】\n"
        "返回extra:【${response.extra.toString()}】\n"
        "返回data:【${encode.convert(response.data)}】");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    debugPrint(
        "*************❌*请求错误*❌************${err.response?.realUri.path}\n"
        "错误码:【${err.toString()}】\n"
        "错误信息response:【${err.response.toString()}】");

    super.onError(err, handler);
  }
}
