import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  bool _expanded = false;

  @override
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _widthAnimation = Tween<double>(
      begin: 80.w,
      end: 1.sw,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _expanded = false;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        _controller.forward();
        setState(() => _expanded = true);
      }
    });
  }

  void _toggleMenu() {
    if (_expanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _expanded = !_expanded);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.75,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 50.w),
      alignment: AlignmentDirectional.bottomEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: _widthAnimation.value,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_widthAnimation.value > 100)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAnimatedNavItem(
                          index: 0,
                          iconPath: Assets.icons.mapIcon,
                          label: "Map",
                          delay: 0.2,
                        ),
                        _buildAnimatedNavItem(
                          index: 1,
                          iconPath: Assets.icons.socialsIcon,
                          label: "Socials",
                          delay: 0.3,
                        ),
                        _buildAnimatedNavItem(
                          index: 2,
                          iconPath: Assets.icons.unitIcon,
                          label: "My Unit",
                          delay: 0.4,
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                RotationTransition(
                  turns: rotationAnimation,
                  child: GestureDetector(
                    onTap: _toggleMenu,
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const SweepGradient(
                          colors: [
                            Color(0xFF006C5D),
                            Color(0xFF03BEA4),
                            Color(0xFF016D5E),
                            Color(0xFF01A08A),
                            Color(0xFF017867),
                            Color(0xFF00B098),
                            Color(0xFF006C5D),
                          ],
                          startAngle: 0.0,
                          endAngle: 6.28,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedNavItem({
    required int index,
    required String iconPath,
    required String label,
    required double delay,
  }) {
    final bool isActive = index == widget.currentIndex;

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Interval(delay, 1, curve: Curves.easeOut),
    );

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.2, 0),
          end: Offset.zero,
        ).animate(curved),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 15.w),
          child: GestureDetector(
            onTap: () => widget.onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSvgIcon(
                  iconPath,
                  size: 28.sp,
                  color: isActive ? Colors.black : Colors.grey.withOpacity(0.4),
                ),
                SizedBox(height: 5.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? Colors.black
                        : Colors.grey.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
