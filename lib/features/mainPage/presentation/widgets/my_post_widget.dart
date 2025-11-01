import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_assessment/core/presentation/widgets/svg_icon.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/post_model.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/widgets/stories_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/data/enums/post_status_enum.dart';
import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/presentation/widgets/see_more_widget.dart';
import '../../../../core/utils/app_constants.dart';
import '../../data/models/toggle_like_model.dart';
import '../../domain/params/toggle_like_params.dart';
import '../cubits/socials/socials_cubit.dart';
import 'comments_bottom_sheet.dart';

class MyPostWidget extends StatefulWidget {
  final PostModel postItem;
  final SocialsPageCubit cubit;

  const MyPostWidget({super.key, required this.postItem, required this.cubit,});

  @override
  State<MyPostWidget> createState() => _MyPostWidgetState();
}

class _MyPostWidgetState extends State<MyPostWidget> {
  late PostModel _postItem;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _postItem = widget.postItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isApproved = widget.postItem.status == PostStatus.APPROVED;
    final isUnderReview = widget.postItem.status == PostStatus.PENDING_APPROVAL;
    final isNotApproved = widget.postItem.status == PostStatus.NOT_APPROVED;

    Widget buildHeader() {
      if (isUnderReview || isNotApproved) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: isUnderReview
                      ? HexColor.fromHex("#007AFF")
                      : HexColor.fromHex("#FF375F"),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: isUnderReview
                          ? HexColor.fromHex("#007AFF").withOpacity(0.25)
                          : HexColor.fromHex("#FF375F").withOpacity(0.25),
                      blurRadius: 1,
                      spreadRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: CustomSvgIcon(
                  isUnderReview
                      ? Assets.icons.underApproveIcon
                      : Assets.icons.rejectedIcon,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isUnderReview ? "Under review..." : "Post Not Approved",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isUnderReview
                        ? "Usually approved within minutes"
                        : "Unfortunately, your post didn't pass the review",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: Colors.black),
              ),
            ],
          ),
        );
      }

      return Row(
        children: [
          MyStoryWidget(
            onPressed: () {},
            imageUrl:
                AppConstant.profileTempImage,
            seeTitle: false,
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  timeago.format(widget.postItem.createdAt ?? DateTime.now()),
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      );
    }

    Widget buildImageGallery() {
      if ((widget.postItem.mediaUrls?.isEmpty ?? true)) return SizedBox();

      return SizedBox(
        height: 250.0.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.postItem.mediaUrls?.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final imageUrl = widget.postItem.mediaUrls?[index] ?? "";

            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0.w),
              child: CustomNetworkImage(
                url: imageUrl,
                boxFit: BoxFit.cover,
                height: 250.0.h,
                width: widget.postItem.mediaUrls!.length > 1 ? 0.7.sw : 0.9.sw,
                opacity: isApproved ? 1.0 : 0.7,
              ),
            );
          },
        ),
      );
    }

    Widget buildInteractionButtons() {
      if (!isApproved) {
        return SizedBox();
      }

      return Row(
        children: [
          _buildInteractionButton(
            context: context,
            icon: _postItem.isLiked!
                ? Assets.icons.redHeartIcon
                : Assets.icons.heartIcon,
            count: _postItem.likeCount.toString(),
            onTap: () async {
              setState(() {
                isLiked = !isLiked;
                _postItem = _postItem.copyWith(
                  isLiked: isLiked,
                  likeCount: isLiked
                      ? _postItem.likeCount! + 1
                      : _postItem.likeCount! - 1,
                );
              });

              try {
                ToggleLikeModel? res = await widget.cubit.toggleLike(
                  ToggleLikeParams(
                    postId: _postItem.postId!,
                    userId: AppConstant.userId,
                  ),
                );
                if (res != null) {
                  setState(() {
                    _postItem = _postItem.copyWith(
                      isLiked: res.action == "liked" ? true : false,
                      likeCount: res.likeCount,
                    );
                  });
                }
              } catch (e) {
                setState(() {
                  _postItem = _postItem.copyWith(
                    isLiked: false,
                    likeCount: _postItem.isLiked!
                        ? _postItem.likeCount! + 1
                        : _postItem.likeCount! - 1,
                  );
                });
              }
            },
          ),
          SizedBox(width: 10.w),
          _buildInteractionButton(
            context: context,
            icon: Assets.icons.commentIcon,
            count: _postItem.commentCount.toString(),
            onTap: () async {
              var res = await showModalBottomSheet(
                context: context,
                barrierColor: Colors.black.withAlpha(38),
                isScrollControlled: true,
                builder: (context) =>
                    CommentsBottomSheet(postId: widget.postItem.postId ?? ""),
              );
              if (res) {
                setState(() {
                  _postItem = _postItem.copyWith(
                    commentCount: _postItem.commentCount! + 1,
                  );
                });
              }
            },
          ),
          SizedBox(width: 10.w),
          _buildInteractionButton(
            context: context,
            icon: Assets.icons.shareIcon,
            onTap: () {},
          ),
        ],
      );
    }

    return Column(
      children: [
        buildHeader(),
        Container(
          width: 1.sw,
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: isApproved ? Colors.white : Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: isApproved
                ? null
                : Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUnderReview && !isNotApproved)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeeMoreWidget(text: widget.postItem.content ?? ""),
                      SizedBox(height: 16.h),
                      buildImageGallery(),
                      SizedBox(height: 16.h),
                      buildInteractionButtons(),
                    ],
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeeMoreWidget(text: widget.postItem.content ?? ""),
                      SizedBox(height: 16.h),
                      buildImageGallery(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionButton({
    required BuildContext context,
    required String icon,
    String? count,
    required VoidCallback? onTap,
  }) {
    return Row(
      children: [
        CustomSvgIcon(icon, size: 23.w, onTab: onTap),
        if (count != null) ...[
          SizedBox(width: 6.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: HexColor.fromHex("#dedede").withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              count ?? "",
              style: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
