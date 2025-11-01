import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:micropolis_assessment/core/presentation/widgets/svg_icon.dart';
import 'package:micropolis_assessment/core/utils/app_constants.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/domain/domain/params/show_image_params.dart';
import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/presentation/widgets/see_more_widget.dart';
import '../../../../router.dart';
import '../../data/models/toggle_like_model.dart';
import '../../domain/params/toggle_like_params.dart';
import '../cubits/socials/socials_cubit.dart';
import 'comments_bottom_sheet.dart';

class PostWidget extends StatefulWidget {
  final PostModel postItem;
  final SocialsPageCubit cubit;

  const PostWidget({
    super.key,
    required this.postItem,
    required this.cubit,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late PostModel _postItem;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _postItem = widget.postItem;
    super.initState();
  }

  void _onPhotoClick({bool isStatus = true}) {
    if (_postItem.mediaUrls!.isEmpty) {
      return;
    }

    if (_postItem.hasNewStory ?? false) {
      setState(() {
        _postItem = _postItem.copyWith(hasNewStory: false);
      });
    }

    context.push(
      AppPaths.external.showImage,
      extra: ShowImageParams(
        imageUrl: _postItem.mediaUrls!.first,
        isStatus: isStatus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => _onPhotoClick(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border:
                        (_postItem.mediaUrls?.isNotEmpty ?? false) &&
                            (_postItem.hasNewStory ?? false)
                        ? Border.all(color: const Color(0xFFE67E22), width: 3)
                        : null,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Center(
                      child: CustomNetworkImage(
                        url:
                            "https://i.ibb.co/4RDXfYqc/2-BO33-NIN75-HOBFERE5-WUYAFRLA.jpg",
                        boxFit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postItem.user?.username ?? "",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      timeago.format(
                        widget.postItem.createdAt ?? DateTime.now(),
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          SeeMoreWidget(text: widget.postItem.content ?? ""),

          if (widget.postItem.mediaUrls!.isNotEmpty) ...[
            SizedBox(height: 16.0.h),

            SizedBox(
              height: 250.0.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.postItem.mediaUrls?.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final imageUrl = widget.postItem.mediaUrls?[index] ?? "";

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.0.w),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        _onPhotoClick(isStatus: false);
                      },
                      child: CustomNetworkImage(
                        url: imageUrl,
                        boxFit: BoxFit.cover,
                        height: 250.0.h,
                        width: widget.postItem.mediaUrls!.length > 1
                            ? 0.7.sw
                            : 0.9.sw,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          SizedBox(height: 16.h),

          Row(
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
                    isDismissible: false,
                    barrierColor: Colors.black.withAlpha(38),
                    isScrollControlled: true,
                    builder: (context) => CommentsBottomSheet(
                      postId: widget.postItem.postId ?? "",
                    ),
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
          ),
        ],
      ),
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
