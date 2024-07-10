part of JWTools;

class JWToastUtil {
  static void showToastCenter(String msg) {
    EasyLoading.instance
      ..textPadding = const EdgeInsets.only(bottom: 10.0)
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      );
    EasyLoading.showToast(msg,
        duration: const Duration(seconds: 2),
        toastPosition: EasyLoadingToastPosition.center,
        maskType: EasyLoadingMaskType.clear);
  }

  static void showSuccessToast(String msg) {
    EasyLoading.instance
      ..textPadding = const EdgeInsets.only(bottom: 10.0)
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      );
    EasyLoading.showSuccess(msg,
        duration: const Duration(seconds: 2),
        maskType: EasyLoadingMaskType.clear);
  }
}
