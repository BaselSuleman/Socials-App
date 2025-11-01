import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgIcon extends StatelessWidget {
  final String path;
  final double? size;
  final Color? color;
  final BoxFit fit;
  final VoidCallback? onTab;

  const CustomSvgIcon(
    this.path, {
    super.key,
    this.size,
    this.color,
    this.fit = BoxFit.contain,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTab,
      child: Center(
        child: SvgPicture.asset(
          path,
          width: size,
          height: size,
          color: color,
          fit: fit,
        ),
      ),
    );
  }
}
