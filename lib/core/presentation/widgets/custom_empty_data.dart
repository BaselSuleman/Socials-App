import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomEmptyData extends StatelessWidget {
  const CustomEmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 24.h,
        ),
        Text(
          "No Items Found",
          style: context.textTheme.headlineLarge,
        ),
      ],
    ));
  }
}
