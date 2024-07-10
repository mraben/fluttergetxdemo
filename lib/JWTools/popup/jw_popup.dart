import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const int _windowPopupDuration = 250;
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const Duration _kWindowDuration = Duration(milliseconds: _windowPopupDuration);
typedef AnimatedWidgetBuilder = Widget Function(BuildContext context,
    Animation<double> animation, Animation<double> secondaryAnimation);

class JWPopupRoute<T> extends PopupRoute<T> {
  JWPopupRoute({
    required this.offset,
    this.barrierLabel,
    required this.barrierDismissible,
    this.duration,
    required this.windowBuilder,
    this.closed,
  });
  final Offset offset;
  VoidCallback? closed;
  final int? duration;
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
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    
    return CustomSingleChildLayout(
          delegate: _JWPopupWindowLayout(offset: offset),
          child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return windowBuilder(context, animation, secondaryAnimation);
              }),
        );
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration =>
      (this.duration == null || this.duration == 0)
          ? _kWindowDuration
          : Duration(milliseconds: duration!);

  @override
  Animation<double> createAnimation() {
    // TODO: implement createAnimation
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd));
  }

  @override
  bool didPop(T? result) {
    // TODO: implement didPop
    this.closed?.call();
    return super.didPop(result);
  }

  @override
  TickerFuture didPush() {
    // TODO: implement didPush
    return super.didPush();
  }
}

class _JWPopupWindowLayout extends SingleChildLayoutDelegate {
  _JWPopupWindowLayout({required this.offset});
  final Offset offset;

  @override
  bool shouldRelayout(_JWPopupWindowLayout oldDelegate) {
    return offset != oldDelegate.offset;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y = offset.dy;
    double x = offset.dx;
    if (offset.dx + childSize.width > size.width) {
      x = size.width - childSize.width;
    }
    if (offset.dy + childSize.height > size.height) {
      y = size.height - childSize.height;
    }

    return Offset(x, y);
  }
}

showPopupWindow<T>({
  required BuildContext context,
  required Offset offset,
  int? duration,
  bool? emptyDismissable = false,
  VoidCallback? closed,// touch emptyView dismissAble
  required AnimatedWidgetBuilder windowBuilder,
}) {
  Navigator.push(
      context,
      JWPopupRoute(
          offset: offset,
          windowBuilder: windowBuilder,
          closed: closed,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierDismissible: emptyDismissable!));
}
