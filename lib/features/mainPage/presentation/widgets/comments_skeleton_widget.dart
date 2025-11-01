import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/extentions.dart';

class CommentsSkeletonWidget extends StatelessWidget {
  const CommentsSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        duration: const Duration(seconds: 1),
      ),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 3,
        separatorBuilder: (_, __) =>
            Divider(color: HexColor.fromHex("e2e3e3"), height: 40.h),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14.h,
                      width: 120.w,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 12.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 12.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 12.h,
                      width: 150.w,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
