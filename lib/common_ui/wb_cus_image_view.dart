import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../JWTools/jw_tools.dart';
import 'package:universal_html/html.dart';
import 'dart:ui_web' as ui;


class WBCusImageView extends StatelessWidget {
  String icon;
  double? width;
  double? height;
  BoxFit? fit;
   WBCusImageView({Key? key,
   required this.icon,
   this.width,
   this.height,
   this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon.startsWith("http")) {
      return PlatformUtils().isWeb ? Image.network(
              icon,
              fit: fit,
              width: width,
              height: height,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(color: viewbgColor,); // 加载失败时显示错误图标
              },
            )
          : CachedNetworkImage(
              imageUrl: icon,
              fit: fit,
              width: width,
              height: height,
              placeholder: (context, url) => Container(
                color: Colors.grey,
              ),
            );
    }
    if (icon.isEmpty) {
      return Container();
    }
    return Image.asset(icon,fit: fit,width: width,height: height,);
  }
}



class WebImage extends StatelessWidget{
  String url;
  double width;
  double height;

  WebImage(this.url, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    String _divId = "web_image_$url";
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _divId,
          (int viewId) => ImageElement(src: url,width: width.toInt(),height: height.toInt())..style.width="100%"
      ..style.height="100%",
    );
    return SizedBox(
      width: width,
      height: height,
      child: HtmlElementView(key: UniqueKey(),
        viewType: _divId,),
    );
  }

}

