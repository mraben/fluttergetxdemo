import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:demoflutter/internationalization/wb_translate_messages.dart';
import 'package:demoflutter/pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'custom_animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  JWManager();
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {
      // empty debugPrint implementation in the release mode
    };
  }

  await GetStorage.init();
  configLoading();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      splitScreenMode: true,
      ensureScreenSize: true,
      minTextAdapt: true,
      builder: (context, _) {
        return GetMaterialApp(
          // debugShowCheckedModeBanner: false,
          navigatorKey: _rootNavigatorKey,
          initialRoute: Routes.TABBAR,
          translations: WBTranslateMessages(),
          supportedLocales: const [Locale("zh", "CN")],
          locale: const Locale("zh", "CN"),
          fallbackLocale: const Locale("zh", "CN"),
          routingCallback: (routing) {
            print("lastRoute:${routing?.previous},current:${routing?.current}");
          },
          title: "Demo",
          color: Colors.blue,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          defaultTransition: Transition.cupertino,
          theme: ThemeData(
              primaryColor: themeColor,
              primarySwatch: Colors.yellow,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              fontFamily: "Demo Family",
              hoverColor: Colors.transparent,
              tabBarTheme: const TabBarTheme(
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory),
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  systemOverlayStyle: statusBarOverlay,
                  elevation: 0,
                  centerTitle: true,
                  foregroundColor: Colors.white,
                  titleTextStyle: WBFontStyle.copyWith(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: "Demo Family",
                      fontWeight: FontWeight.bold),
                  shadowColor: Colors.transparent)),
          getPages: AppPages.pages,
          builder: EasyLoading.init(builder: (context, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: () => _hideKeyboard(context),
                child: child,
              ),
            );
          }),
        );
      },
    );
    // return Container(child:Center(child: Text("123"),),);
  }

  /// 全局键盘管理(点击空白收起键盘)
  void _hideKeyboard(BuildContext context) {
    FocusScopeNode scopeNode = FocusScope.of(context);
    if (!scopeNode.hasPrimaryFocus && scopeNode.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..textPadding = EdgeInsets.fromLTRB(20, 15, 20, 15)
    ..contentPadding = const EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 20.0,
    )
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
