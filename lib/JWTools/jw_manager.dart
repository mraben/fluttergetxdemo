part of JWTools;

final eventBus = EventBus();

class JWManager {

  static final JWManager _instance = JWManager._internal();

  final bool isPhoneLogin = false; //是否手机号登录

  final SP_ID = "SP_ID";
  WbConfigModel? configModel;

  String? language;
  String? token = "";

  late Map<String, dynamic> configMap;

  factory JWManager() {
    return _instance;
  }

  JWManager._internal() {
    init();
  }

  void init() {
    token = GetStorage().read(TOKEN_KEY);
  }

  bool get isLogined {
    return token != null && (token?.isNotEmpty == true);
  }

  void logout() async {}

  String? getAppName() {
    return configMap['AppName'];
  }

  String? getUrl() {
    return configMap["Url"];
  }

  Future<Map<String, dynamic>> getLocalJson(String jsonName) async {
    Map<String, dynamic> map =
        jsonDecode(await rootBundle.loadString("assets/local/$jsonName.json"));
    return map;
  }

  bool checkLogin() {
    if (!isLogined) {
      Get.toNamed(Routes.LOGIN);
    }
    return isLogined;
  }

  void showLoginPopUp(bool isShow) {
    if (isShow) {
      showBottomSheetWindow(
          context: Get.context!,
          emptyDismissable: true,
          windowBuilder: (context, from, to) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Image.asset(
                        "assets/mine/mine_portrait.png",
                        width: 66,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "未登录",
                            style: WBFontStyle.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "精彩内容登登录体验！",
                            style: WBFontStyle.copyWith(
                                color: Colors.black, fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                DottedLine(
                  dashColor: viewbgColor,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ThemeOuterBtn(
                          title: "取消",
                          height: 44,
                          radius: 10,
                          width: Get.width / 2 - 15,
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          onPressed: () {
                            Get.back();
                          }),
                      ThemeEnterBtn(
                          title: "登录",
                          height: 44,
                          radius: 10,
                          width: Get.width / 2 - 15,
                          margin: const EdgeInsets.fromLTRB(0, 20, 10, 20),
                          onPressed: () {
                            Get
                              ..back()
                              ..toNamed(Routes.LOGIN);
                          })
                    ],
                  ),
                )
              ],
            );
          },
          closed: () {
            JWToastUtil.showToastCenter("关闭");
          });
    }
  }

  void showLogoutPopUp() {
    showBottomSheetWindow(
        context: Get.context!,
        emptyDismissable: true,
        windowBuilder: (context, from, to) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 50,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/mine/mine_portrait.png",
                      width: 66,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "退出账号",
                          style: WBFontStyle.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        // Text("精彩内容等你来体验，快去登录吧！",style: WBFontStyle.copyWith(color: Colors.black,fontSize: 14),),
                      ],
                    )
                  ],
                ),
              ),
              DottedLine(
                dashColor: viewbgColor,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    ThemeOuterBtn(
                        title: "取消",
                        height: 44,
                        radius: 10,
                        width: Get.width / 2 - 15,
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        onPressed: () {
                          Get.back();
                        }),
                    ThemeEnterBtn(
                        title: "确定",
                        height: 44,
                        radius: 10,
                        width: Get.width / 2 - 15,
                        margin: const EdgeInsets.fromLTRB(0, 20, 10, 20),
                        onPressed: () {
                          JWManager().logout();
                          Get.back();
                        })
                  ],
                ),
              )
            ],
          );
        });
  }
}
