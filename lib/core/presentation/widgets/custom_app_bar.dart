import 'package:flutter/material.dart';

ContinuousRectangleBorder continuousRectangleBorder =
    const ContinuousRectangleBorder();

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color? color;
  final Color? titleColor;
  final double? elevation;

  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.titleColor,
    this.elevation,
    this.bottom,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 0.3,
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.copyWith(color: titleColor),
      ),
      actions: actions,
      shape: continuousRectangleBorder,
      centerTitle: true,
      leading: leading,
      backgroundColor: color,

      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
