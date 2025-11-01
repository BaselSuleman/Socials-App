import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';

import '../../../../core/presentation/widgets/network_image.dart';

class SocialsAvatarStackWidget extends StatelessWidget {
  final List<String> avatars;
  final int extraCount;

  const SocialsAvatarStackWidget({
    super.key,
    required this.avatars,
    this.extraCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarSize = 50.w;
    final double overlap = 15.w;
    final int displayCount = avatars.length > 3 ? 3 : avatars.length;
    final double addButtonWidth = 100.w;

    final double totalWidth =
        (displayCount * (avatarSize - overlap)) + addButtonWidth;

    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Center(
        child: SizedBox(
          width: totalWidth,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < displayCount; i++)
                Positioned(
                  left: i * (avatarSize - overlap),
                  child: Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: ClipOval(
                      child: CustomNetworkImage(
                        url: avatars[i],
                      ),
                    ),
                  ),
                ),

              Positioned(
                left: displayCount * (50.w - overlap),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: HexColor.fromHex("#ff375f"),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 4.h,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          SizedBox(width: 5.w),
                          Text(
                            "Add",
                            style: context.textTheme.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor.fromHex("#78788052"),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
