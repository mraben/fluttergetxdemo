part of JWTools;

class JWLoadingDialog extends Dialog {
  static dynamic globalCtx;
  String? showStr;

  JWLoadingDialog({super.key, this.showStr});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            color: Colors.white,
          ),
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          child: _progressHUD(globalCtx),
        ),
      ),
    );
  }

  Widget _progressHUD(BuildContext context) {
    List<Widget> arr = [const CircularProgressIndicator()];

    if (this.showStr != null) {
      arr.add(Text(this.showStr!,
          style: WBFontStyle.copyWith(
            fontSize: 12,
            color: Colors.black38,
          ),
          softWrap: false));
    }
    var hud =
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: arr);
    return hud;
  }

  static void hideHud() {
    Navigator.pop(globalCtx);
  }

  static void showHud(String? str) {
    showDialog(
        context: globalCtx,
        barrierDismissible: false,
        builder: (context) {
          return JWLoadingDialog(showStr: str);
        });
  }

  /// 如果当前页有其他dialog操作的需要调用该方法
  /// [context]传入当前页context [str] 传入hud展示string
  static void showHudWithContext(BuildContext context, String? str) {
    globalCtx = context;
    showHud(str);
  }
}
