import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToast {
  static OverlayEntry? _currentOverlay;
  static bool _isShowing = false;

  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    required Widget icon,
    VoidCallback? onTap,
    Color iconColor = Colors.green,
  }) {
    if (_isShowing) {
      _currentOverlay?.remove();
      _currentOverlay = null;
      _isShowing = false;
    }

    final overlay = Overlay.of(context);

    _currentOverlay = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 16.h,
        left: 16.w,
        right: 16.w,
        child: SafeArea(
          top: false,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (onTap != null)
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _currentOverlay?.remove();
                          _isShowing = false;
                          onTap();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_currentOverlay!);
    _isShowing = true;

    Future.delayed(duration, () {
      if (_currentOverlay?.mounted ?? false) {
        _currentOverlay?.remove();
        _currentOverlay = null;
        _isShowing = false;
      }
    });
  }
}
