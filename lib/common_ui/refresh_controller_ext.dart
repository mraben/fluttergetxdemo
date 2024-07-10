import 'package:pull_to_refresh/pull_to_refresh.dart';

extension WBRefresh on RefreshController {
   RefreshController finishedWithArrs({List? arr,int? length}) {
    var arrLength = arr?.length ?? 0;
    if (arrLength < (length ?? 10)) {
      refreshCompleted();
      loadNoData();
    }else {
      resetNoData();
      refreshCompleted();
      loadComplete();
    }
    return this;
  }
}