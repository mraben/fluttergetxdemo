part of JWTools;


class ImageIndicator extends Decoration {
  /// 指示器图标
  final ui.Image image;
  final Size imageSize;
  final EdgeInsetsGeometry insets;

  const ImageIndicator(
      {required this.image,
        this.imageSize = const Size(9, 4.5),
        this.insets = EdgeInsets.zero});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return ImageUnderlinePainter(this, image, imageSize, onChanged);
  }

}
class ImageUnderlinePainter extends BoxPainter {
  final ui.Image image;
  final Size imageSize;
  ImageUnderlinePainter(
      this.decoration, this.image, this.imageSize, VoidCallback? onChanged)
      : super(onChanged);

  final ImageIndicator decoration;
  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    double cw = (indicator.left + indicator.right) / 2;
    var wantWidth = imageSize.width.toDouble();
    return Rect.fromLTWH(cw - wantWidth / 2, indicator.bottom, wantWidth,
        imageSize.height.toDouble());
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator =
    _indicatorRectFor(rect, textDirection).deflate(imageSize.width / 2);
    final Paint paint = Paint();
    canvas.drawImage(
        image,
        Offset(indicator.center.dx - imageSize.width / 2,
            indicator.center.dy - imageSize.height + insets.vertical),
        paint);
  }
}