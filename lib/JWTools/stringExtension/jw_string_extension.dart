part of JWTools;
extension jwString on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return const Color(0x00ffffff);
  }
  bool impossibleOpCode() {
    return this == "androidOpNoChannel" || this == "iOSNoAigp" || this.isEmpty;
  }
  appendHttp() {
    if (contains("http")) {
      return this;
    }
    return "http://${this}";
  }
  appendImgUrl() {
    if (contains("http")) {
      return this;
    }
    return JWApi.imgBaseUrl + this;
  }

  thumb({int w = 200,int h = 200}) {
    return '$this?x-oss-process=image/resize,m_fill,h_$h,w_$w';
  }

  bool validEmail() {
    var input = this;
    if (input.isEmpty) return false;
    // 邮箱正则
    String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    return RegExp(regexEmail).hasMatch(input);
  }

  // HHmm = 时:分
  DateTime parseTime() {
    var HHmm = this;

    if (HHmm.length >= 8) {
      return DateTime.parse(HHmm);
    }
    if (HHmm.contains(':') && HHmm.length >= 3) {
      var _now = DateTime.now();
      var HH = HHmm.split(':').first;
      var mm = HHmm.split(':').last;
      return DateTime(
          _now.year, _now.month, _now.day, int.parse(HH), int.parse(mm));
    }

    return DateTime.now();
  }

  static String messageTime(int? timeStamp) {
    // 当前时间
    int time = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    // 对比
    int _distance = time - (timeStamp ?? 0);
    if (_distance <= 60) {
      return '刚刚';
    } else if (_distance <= 3600) {
      return '${(_distance / 60).floor()}分钟前';
    } else if (_distance <= 43200) {
      return '${(_distance / 60 / 60).floor()}小时前';
    } else if (DateTime.fromMillisecondsSinceEpoch(time * 1000).year ==
        DateTime.fromMillisecondsSinceEpoch((timeStamp ?? 0) * 1000).year) {
      return DateUtil.formatDateMs((timeStamp ?? 0) * 1000,
          format: DateFormats.mo_d_h_m);
    } else {
      return DateUtil.formatDateMs((timeStamp ?? 0) * 1000,
          format: DateFormats.y_mo_d_h_m);
    }
  }

  bool cnIsNumber() {
    final reg = RegExp(r'^-?[0-9.]+$');
    var val = reg.hasMatch(this);

    return val;
  }
  double toDouble() {
    if (cnIsNumber()) {
      try {
        double p = double.tryParse(this) ?? 0.0;
        return p;
      } catch(e) {
        try {
          double p = int.tryParse(this)?.toDouble() ?? 0.0;
          return p;
        }catch (e) {
          return 0.0;
        }
      }
    }
    print("不是数字类型");
    return 0.0;
  }
  int toInt() {
    if (cnIsNumber()) {
      try {
        int p = int.tryParse(this) ?? 0;
        return p;

      } catch(e) {
        try {
          double p = double.tryParse(this) ?? 0.0;
          return p.toInt();
        }catch (e) {
          return 0;
        }
      }
    }
    return 0;
  }
  double paintWidthWithTextStyle(TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: this, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

}
