import 'package:flutter/material.dart';
import 'package:flutter_base/base/extension/common_extentions.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String imageUrl;
  final num? height;
  final num? width;
  final Color? color;

  const SvgImage(this.imageUrl, {Key? key, this.height, this.width, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageUrl,
      color: color,
      width: width?.toString().toDouble(),
      height: height?.toString().toDouble(),
    );
  }
}
