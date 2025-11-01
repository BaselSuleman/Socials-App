import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:micropolis_assessment/core/presentation/widgets/error_panel.dart';
import 'package:micropolis_assessment/core/utils/app_constants.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/comments/comments_cubit.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/widgets/stories_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/presentation/widgets/action_button.dart';
import '../../../../core/presentation/widgets/see_more_widget.dart';
import '../../data/models/comments_model.dart';
import '../../data/models/user_model.dart';
import 'comments_skeleton_widget.dart';

class CommentsBottomSheet extends StatefulWidget {
  final String postId;

  const CommentsBottomSheet({super.key, required this.postId});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  late final CommentsCubit cubit;
  bool addedMore = false;

  @override
  void initState() {
    cubit = CommentsCubit();
    cubit.getComments(widget.postId);
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    cubit.close();
    super.dispose();
  }

  void _scrollToLast() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      addedMore = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsCubit, CommentsState>(
      bloc: cubit,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 0.52.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Row(
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      ActionButton(
                        onPressed: () {
                          context.pop(addedMore);
                        },
                        height: 30.h,
                        width: 30.w,
                        radius: 100.r,
                        backgroundColor: HexColor.fromHex("#d2d2d2"),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: HexColor.fromHex("7c7c7c"),
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.status == CommentsStatus.loading
                      ? CommentsSkeletonWidget()
                      : state.status == CommentsStatus.error
                      ? ErrorPanel(
                          failure: state.failure!,
                          onTryAgain: () {
                            cubit.getComments(widget.postId);
                          },
                        )
                      : (state.comments == null || state.comments!.isEmpty)
                      ? Center(
                          child: Text(
                            "No comments yet. Be the first to comment!",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        )
                      : ListView.separated(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          itemBuilder: (context, index) {
                            return _buildComment(
                              name:
                                  state.comments![index].user?.userId ==
                                      AppConstant.userId
                                  ? "YOU"
                                  : state.comments![index].user?.username ?? "",
                              time: state.comments![index].createdAt!,
                              text: state.comments![index].content ?? "",
                              avatarUrl:
                                  state.comments![index].user?.profileImage,
                              userId: state.comments![index].userId!,
                              loading:
                                  state.status == CommentsStatus.addLoading &&
                                  state.comments![index].user?.userId ==
                                      AppConstant.userId &&
                                  state.comments![index].commentId == '',
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: HexColor.fromHex("e2e3e3"),
                              height: 40.h,
                            );
                          },
                          itemCount: state.comments!.length,
                        ),
                ),

                SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    ),
                    child: Row(
                      children: [
                        MyStoryWidget(
                          onPressed: () {},
                          imageUrl: AppConstant.profileTempImage,
                          seeTitle: false,
                          height: 40.h,
                          width: 40.w,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: commentController,
                            builder: (context, value, child) {
                              final hasText = value.text.trim().isNotEmpty;
                              return TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: 'Add a helpful comment…',
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: HexColor.fromHex("e3e3e3"),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: HexColor.fromHex("e3e3e3"),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  isDense: true,

                                  suffixIcon: hasText
                                      ? TextButton(
                                          onPressed: () {
                                            final text = value.text.trim();
                                            if (text.isEmpty) return;
                                            _scrollToLast();
                                            final newComment = CommentModel(
                                              content: text,
                                              commentId: '',
                                              postId: widget.postId,
                                              userId: AppConstant.userId,
                                              createdAt: DateTime.now(),
                                              user: User(
                                                userId: AppConstant.userId,
                                                username: "You",
                                                profileImage:
                                                    AppConstant.profileTempImage,
                                              ),
                                            );
                                            cubit.addComment(newComment);
                                            commentController.clear();
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: Text(
                                            'Send',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                                minLines: 1,

                                onTapOutside: (event) =>
                                    FocusScope.of(context).unfocus(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget _buildComment({
    required String name,
    required String userId,
    required DateTime? time,
    required String text,
    required String? avatarUrl,
    bool? loading = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyStoryWidget(
          onPressed: () {},
          imageUrl: avatarUrl,
          seeTitle: false,
          height: 40.h,
          width: 40.w,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                timeago.format(time ?? DateTime.now()),
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
              ),
              SizedBox(height: 10.h),
              SeeMoreWidget(text: text),
              if (loading!)
                Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      "Posting....",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (userId == AppConstant.userId)
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {})
        else
          SizedBox.shrink(),
      ],
    );
  }
}
