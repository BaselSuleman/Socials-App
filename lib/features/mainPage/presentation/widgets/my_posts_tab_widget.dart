import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/widgets/post_skeleton_widget.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/paginated_list.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../data/models/post_model.dart';
import '../cubits/socials/socials_cubit.dart';
import 'my_post_widget.dart';
class MyPostsTab extends StatefulWidget {
  final SocialsPageCubit cubit;
  const MyPostsTab({super.key, required this.cubit});

  @override
  State<MyPostsTab> createState() => _MyPostsTabState();
}

class _MyPostsTabState extends State<MyPostsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PaginatedList<PostModel>(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      paginationCubit: widget.cubit.userPaginationCubit,
      isPaginated: true,
      itemBuilder: (item) => MyPostWidget(postItem: item, cubit: widget.cubit),
      separator: Divider(endIndent: 20.w, indent: 20.w),
      skeletonItemBuilder: (context, index) => const PostSkeleton(),
      noData: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgIcon(Assets.icons.noResultSearch, size: 120.sp),
            SizedBox(height: 8.h),
            Text(
              "No posts yet\nCreate a new post to get started!",
              style: context.textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
