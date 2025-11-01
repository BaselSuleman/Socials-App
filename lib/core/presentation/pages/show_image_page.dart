import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:micropolis_assessment/core/presentation/widgets/network_image.dart';
import '../../domain/domain/params/show_image_params.dart';

class ShowImagePage extends StatefulWidget {
  final ShowImageParams showImageParams;

  const ShowImagePage({super.key, required this.showImageParams});

  @override
  State<ShowImagePage> createState() => _ShowImagePageState();
}

class _ShowImagePageState extends State<ShowImagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.showImageParams.isStatus) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 5),
      )..forward();

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.showImageParams.isStatus) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomNetworkImage(
              url: widget.showImageParams.imageUrl,
              boxFit: BoxFit.contain,
              useSkeletonizer: false,
            ),
          ),

          if (widget.showImageParams.isStatus)
            Positioned(
              top: MediaQuery.of(context).padding.top + 20.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _controller.value,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      color: Colors.white,
                      minHeight: 4,
                    );
                  },
                ),
              ),
            ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 30.h,
            right: 16.w,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
