import 'package:flutter/cupertino.dart';

import '../r.dart';

class WBCusEmptyView extends StatelessWidget {
  double? width;
   WBCusEmptyView({Key? key,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
        Image.asset(R.assetsImageIconGoogle,width: width ?? 180,)
      // Lottie.asset(
      //   "assets/lottie/empty_order.zip", width: width ?? 180,),
    );
  }
}
