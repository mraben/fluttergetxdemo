part of JWTools;

const int _windowPopupDuration = 250;
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const Duration _kWindowDuration = Duration(milliseconds: _windowPopupDuration);
typedef AnimatedWidgetBuilder = Widget Function(BuildContext context,
    Animation<double> animation, Animation<double> secondaryAnimation);

class JWBottomSheet<T> extends PopupRoute<T> {
  JWBottomSheet({
    this.barrierLabel,
    required this.barrierDismissible,
    this.closed,
    this.duration,
    required this.windowBuilder,
  });
  final int? duration;
  VoidCallback? closed;
  final AnimatedWidgetBuilder windowBuilder;

  @override

  /// TODO: implement barrierColor
  Color? get barrierColor => Colors.black45;

  @override
  // TODO: implement barrierDismissible
  final bool barrierDismissible;

  @override
  // TODO: implement barrierLabel
  final String? barrierLabel;
  
  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: Interval(0.0, _kWindowCloseIntervalEnd));
  }
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return CustomSingleChildLayout(delegate: JWBottomSheetWindow(animation.value),
    child: AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context,Widget? child) {
        return windowBuilder(context,animation,secondaryAnimation);
      },
    ),);
  }
  @override
  bool didPop(T? result) {
    this.closed?.call();
    // TODO: implement didPop
    return super.didPop(result);
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => 
      (this.duration == null || this.duration == 0)
          ? _kWindowDuration
          : Duration(milliseconds: duration!);
}

class JWBottomSheetWindow extends SingleChildLayoutDelegate {
  JWBottomSheetWindow(this.progress,);
  final double progress;
  @override
  bool shouldRelayout(JWBottomSheetWindow oldDelegate) {
    return progress != oldDelegate.progress;
  }
  @override
  Offset getPositionForChild(Size size, Size childSize) {
     final height = size.height - childSize.height;
    return Offset(0.0, height);
  }
  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // TODO: implement getConstraintsForChild
    return BoxConstraints.loose(constraints.biggest);
  }
  
  
}

Future<T?> showBottomSheetWindow<T>({
  required BuildContext context,
   int? duration,
  VoidCallback? closed,
  bool? emptyDismissable = false, // touch emptyView dismissAble
  required AnimatedWidgetBuilder windowBuilder,
}) {
  return Navigator.push<T?>(context, JWBottomSheet(
    barrierDismissible: emptyDismissable!,
    windowBuilder: windowBuilder,
    closed: closed,
  ));

}
