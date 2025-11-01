import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_assessment/core/presentation/widgets/svg_icon.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/widgets/socials_avatar_widget.dart';

import '../../../../core/presentation/resources/assets.gen.dart';

class SocialsAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SocialsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: SocialsAvatarStackWidget(
        avatars: [
          'https://i.ibb.co/TDtxs1dK/photo-1599475735868-a8924c458792.jpg',
          'https://i.ibb.co/LzwGPj0T/photo-1494790108377-be9c29b29330.jpg',
        ],
        extraCount: 9,
      ),
      leading:CustomSvgIcon(Assets.icons.drawerIcon),
      actions: [
        CustomSvgIcon(Assets.icons.notificationIcon),
        SizedBox(width: 20.w,)
      ],

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}