import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? radius;

  const ActionButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.height,
    this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8.r),
          color: effectiveBackgroundColor,
        ),
        child: child,
      ),
    );
  }
}
