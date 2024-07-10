part of JWTools;

class JWTextFieldAlert extends Dialog {
  String holder;
  String? cancelTitle;
  String? enterTitle;
  VoidCallback? cancelCallBack;
  ValueChanged<String>? enterCallBack;
  Color? enterColor;
  TextEditingController textController;
  TextInputType? textInputType;
  String? unitStr;
  int? maxLength;

  JWTextFieldAlert(
      {required this.holder,
      required this.textController,
      this.cancelTitle,
      this.enterTitle,
      this.cancelCallBack,
      this.enterCallBack,
      this.enterColor,
      this.textInputType,
      this.unitStr,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    log("dialog build ");
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 28, right: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 50,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: "#F7F8FC".toColor(),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: "#e6e6e6".toColor(), width: 0.5)),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          textAlign: TextAlign.left,
                          controller: textController,
                          keyboardType: textInputType,
                          decoration: InputDecoration(
                            hintText: holder,
                            border: InputBorder.none,
                          ),
                          maxLength: maxLength,
                        ),
                      ),
                      Offstage(
                        offstage: unitStr == null,
                        child: Text(
                          unitStr ?? "",
                          style: WBFontStyle.copyWith(color: textColor3, fontSize: 16),
                        ),
                      )
                    ],
                  )),
              Divider(
                height: 1,
                color: backgroundColor,
              ),
              Container(
                height: 56,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: TextButton(
                            child: Text(
                              cancelTitle ?? "取消",
                              style: WBFontStyle.copyWith(
                                  fontSize: 17,
                                  color: textColor2,
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: cancelCallBack != null
                                ? cancelCallBack
                                : () {
                                    Navigator.of(context).pop();
                                  },
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1, color: viewbgColor1)),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: TextButton(
                            child: Text(
                              enterTitle ?? "确定",
                              style: WBFontStyle.copyWith(
                                  fontSize: 17,
                                  color: enterColor ?? themeColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                              if (enterCallBack != null) {
                                enterCallBack?.call(textController.text);
                                Navigator.pop(context);
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showTextFieldAlert(
    {required BuildContext context,
    required String placeholder,
    required TextEditingController tfController,
    String? cancelTitle,
    String? enterTitle,
    String? unitStr,
    TextInputType? textInputType,
    VoidCallback? cancelCallBack,
    ValueChanged<String>? enterCallBack,
    int? maxLength,
    Color? enterColor}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return JWTextFieldAlert(
          textController: tfController,
          holder: placeholder,
          cancelTitle: cancelTitle,
          cancelCallBack: cancelCallBack,
          enterTitle: enterTitle,
          enterColor: enterColor,
          enterCallBack: enterCallBack,
          unitStr: unitStr,
          textInputType: textInputType,
          maxLength: maxLength,
        );
      });
}
