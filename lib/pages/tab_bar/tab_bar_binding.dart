import 'package:get/get.dart';

import 'tab_bar_logic.dart';

class Tab_barBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Tab_barLogic());
  }
}
