part of JWTools;

class JWCustomAlert extends Dialog {
  String? title;
  String? content;
  String? cancelTitle;
  String? enterTitle;
  VoidCallback? cancelCallBack;
  VoidCallback? enterCallBack;
  Color? enterColor;
  JWCustomAlert(
      {this.title,
      this.content,
      this.cancelTitle,
      this.enterTitle,
      this.cancelCallBack,
      this.enterCallBack,
      this.enterColor});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          // width: MediaQuery.of(context).size.width*0.4,
          margin: EdgeInsets.only(left: 28, right: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (title != null && title!.isNotEmpty)
                  ? Container(
                      margin: EdgeInsets.fromLTRB(24, 31, 24, (content != null && content!.isNotEmpty) ? 20 : 30),
                      child: Text(
                        title ?? "",
                        style: WBFontStyle.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: textColor3),
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              (content != null && content!.isNotEmpty)
                  ? Container(
                      margin: EdgeInsets.fromLTRB(24, (title != null && title!.isNotEmpty) ? 0:30, 24, 30),
                      child: Text(
                        content ?? '',
                        
                        style: WBFontStyle.copyWith(fontSize: 14, color: textColor3,height: 1.3),
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              
              Divider(
                height: 1,
                color: viewbgColor,
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
                              cancelTitle ?? "Cancel",
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
                              enterTitle ?? "Enter",
                              style: WBFontStyle.copyWith(
                                  fontSize: 17,
                                  color: enterColor ?? themeColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: enterCallBack != null
                                ? enterCallBack
                                : () {
                                    Navigator.of(context).pop();
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

showCustomAlert(
    {required BuildContext context,
    String? title,
    String? content,
    String? cancelStr,
    String? enterStr,
    Color? enterColor,
    VoidCallback? cancelCall,
    bool barrierDismissible = true,
    VoidCallback? enterCall}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return JWCustomAlert(
          title: title,
          content: content,
          cancelTitle: cancelStr,
          enterTitle: enterStr,
          enterColor: enterColor,
          enterCallBack: enterCall,
          cancelCallBack: cancelCall,
        );
      });
}
