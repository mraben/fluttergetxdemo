import 'dart:async';
import 'package:universal_html/js.dart';

class WBJSTools {
  Future<String> deceryptUrl(String url,String aeskey,{Function? timeOutBlock}) {
    JsObject jsPromise = context.callMethod('decryptImage', [url,aeskey]);
    Completer<String> completer = Completer<String>();
    print('执行调用JS');


    Future.delayed(const Duration(milliseconds: 100), () {
      jsPromise.callMethod('then', [
        allowInterop((result) {

          completer.complete(result);
          print('结束调用JS');
        }),
      ]);

      jsPromise.callMethod('catch', [
        allowInterop((error) {

          completer.completeError(error);
          print('JS 报错：${error}');
        }),
      ]);
    });


    return completer.future;
  }

  void saveBase64Image(base64,fileName) {
    context.callMethod('saveBase64Image', [base64,fileName]);
  }
}