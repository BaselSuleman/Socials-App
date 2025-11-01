import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostSkeleton extends StatelessWidget {
  const PostSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r),
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
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        height: 12.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 12.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 12.h,
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            ClipRRect(
              borderRadius: BorderRadius.circular(12.0.r),
              child: Skeletonizer(
                effect: ShimmerEffect(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  duration: const Duration(seconds: 1),
                ),
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              children: [
                _buildSkeletonButton(),
                SizedBox(width: 10.w),
                _buildSkeletonButton(),
                SizedBox(width: 10.w),
                _buildSkeletonButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonButton() {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          height: 12.h,
          width: 30.w,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
      ],
    );
  }
}
