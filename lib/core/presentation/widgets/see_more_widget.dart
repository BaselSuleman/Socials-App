import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeeMoreWidget extends StatefulWidget {
  final String text;

  const SeeMoreWidget({super.key, required this.text});

  @override
  State<SeeMoreWidget> createState() => _SeeMoreWidgetState();
}

class _SeeMoreWidgetState extends State<SeeMoreWidget> {
  bool isLongText = false;
  bool seeMore = false;

  @override
  void initState() {
    isLongText = _isLongText(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: seeMore ? null : 3,
          overflow: seeMore ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp, color: Colors.black),
        ),
        if (isLongText)
          GestureDetector(
            onTap: () {
              setState(() {
                seeMore = !seeMore;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                seeMore ? "See less" : "See more",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  bool _isLongText(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
      ),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: 300.w);
    return textPainter.didExceedMaxLines;
  }
}
