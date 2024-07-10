part of JWTools;

class JWScreenFit {
  static MediaQueryData? _mediaQueryData;
  static double? _pt;
  static void init(BuildContext context,{double measureWidth = 375}) {
    _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData?.size.width;
    _pt = screenWidth! / 375;
  }
  static double widthFixed(double width) {
    assert(_pt != null, "not implement init method of JWScreenFit");
    return _pt! * width;
  }

}
extension JWWidthFixedInt on num {
  double get pt => JWScreenFit.widthFixed(toDouble());
}

