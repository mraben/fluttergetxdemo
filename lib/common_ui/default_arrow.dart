import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../r.dart';
class DefaultArrow extends StatefulWidget {

  const DefaultArrow({super.key});

  @override
  State<DefaultArrow> createState() => _DefaultArrowState();
}

class _DefaultArrowState extends State<DefaultArrow> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(R.assetsImageIconSvgGoogle, width: 20,);
  }
}
