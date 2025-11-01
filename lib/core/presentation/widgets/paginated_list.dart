import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart'; // ✅ Add skeletonizer

import '../../utils/service/pagination_service/pagination_cubit.dart';
import 'custom_empty_data.dart';
import 'error_panel.dart';

class PaginatedList<T> extends StatelessWidget {
  const PaginatedList({
    required this.paginationCubit,
    required this.itemBuilder,
    this.separator,
    this.noData,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.isPaginated = true,
    this.skeletonItemCount = 2,
    this.skeletonItemBuilder,
    super.key,
  }) : gridDelegate = null;

  final PaginationCubit<T> paginationCubit;
  final Widget Function(T) itemBuilder;
  final EdgeInsetsGeometry? padding;
  final Widget? noData;
  final Axis scrollDirection;
  final bool isPaginated;
  final Widget? separator;
  final SliverGridDelegate? gridDelegate;

  final int skeletonItemCount;
  final Widget? Function(BuildContext, int)? skeletonItemBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaginationCubit, PaginationState>(
      bloc: paginationCubit,
      listener: (_, __) {},
      builder: (context, state) {
        return SmartRefresher(
          controller: state.refreshController,
          enablePullUp: isPaginated,
          enablePullDown: true,
          scrollDirection: scrollDirection,
          onRefresh: () async => paginationCubit.load(false),
          onLoading: () => paginationCubit.load(isPaginated),
          footer: CustomFooter(
            builder: (context, mode) {
              Widget body;
              if (mode == LoadStatus.loading) {
                body = Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 18.w,
                      width: 18.w,
                      child: const CupertinoActivityIndicator(),
                    ),
                  ],
                );
              } else if (mode == LoadStatus.noMore) {
                body = Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "That’s all",
                      style: TextStyle(
                        color: HexColor.fromHex("a4a4a4"),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              } else if (mode == LoadStatus.failed) {
                body = Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, size: 20.w, color: Colors.redAccent),
                    SizedBox(width: 6.w),
                    Text(
                      "Tap to retry",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              } else {
                body = const SizedBox();
              }

              return SizedBox(
                height: 50.h,
                child: Center(child: body),
              );
            },
          ),

          child: _buildContent(context, state),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, PaginationState state) {
    if (state.isShowList()) {
      return ListView.separated(
        itemCount: state.paginatedList!.list.length,
        itemBuilder: (_, index) =>
            itemBuilder(state.paginatedList!.list[index]),
        separatorBuilder: (_, __) => separator ?? const SizedBox(),
        scrollDirection: scrollDirection,
        padding: padding,
      );
    }

    if (state.status == PaginationStatus.error) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ErrorPanel(
          failure: state.paginationFailure!,
          onTryAgain: () => paginationCubit.load(false),
        ),
      );
    }

    if (state.status == PaginationStatus.noDataFound) {
      return noData ?? const CustomEmptyData();
    }

    if (state.status == PaginationStatus.initial) {
      return Skeletonizer(
        enabled: true,
        child: ListView.separated(
          itemCount: skeletonItemCount,
          itemBuilder: (context, index) =>
              skeletonItemBuilder?.call(context, index) ??
              _defaultSkeletonItem(context),
          separatorBuilder: (_, __) => separator ?? const SizedBox(),
          padding: padding,
          scrollDirection: scrollDirection,
        ),
      );
    }

    return const SizedBox();
  }

  Widget _defaultSkeletonItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 12, color: Colors.grey[300]),
                const SizedBox(height: 8),
                Container(height: 12, width: 150, color: Colors.grey[300]),
                const SizedBox(height: 8),
                Container(height: 12, width: 100, color: Colors.grey[300]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
