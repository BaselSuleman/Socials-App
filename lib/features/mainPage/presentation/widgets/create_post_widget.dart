import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_assessment/core/presentation/widgets/svg_icon.dart';
import 'package:micropolis_assessment/core/utils/app_constants.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/create_post_params.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/cubits/socials/socials_cubit.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/widgets/stories_widget.dart';
import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/services/image_file_picker_service.dart';
import '../../../../core/presentation/widgets/action_button.dart';

class CreatePostWidget extends StatefulWidget {
  final String? avatarUrl;
  final SocialsPageCubit cubit;

  const CreatePostWidget({super.key, this.avatarUrl, required this.cubit});

  @override
  State<CreatePostWidget> createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  late TextEditingController postController;

  final ImageFilePickerService _pickerService =
      ImageFilePickerService.getInstance();
  List<File> selectedImages = [];

  Future<void> _pickFromCamera() async {
    final file = await _pickerService.pickImageFromCamera(imageQuality: 80);
    if (file != null) setState(() => selectedImages.add(file));
  }

  Future<void> _pickFromGallery() async {
    final files = await _pickerService.multipleImagesFromGallery(
      imageQuality: 80,
    );
    if (files.isNotEmpty) setState(() => selectedImages.addAll(files));
  }

  @override
  void initState() {
    postController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyStoryWidget(
            onPressed: () {},
            imageUrl: widget.avatarUrl ?? AppConstant.profileTempImage,
            seeTitle: false,
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: postController,
                  maxLines: null,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Share something with your neighbors...',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(fontSize: 14.sp),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                ),

                if (selectedImages.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 120.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length,
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 120.h,
                                  maxWidth: 150.w,
                                ),
                                child: Image.file(
                                  selectedImages[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: 5.h,
                              end: 5.w,
                              child: GestureDetector(
                                onTap: () => setState(
                                  () => selectedImages.removeAt(index),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: HexColor.fromHex(
                                      "f7f7f7",
                                    ).withAlpha(190),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: HexColor.fromHex("989898"),
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],

                SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (selectedImages.length < 2)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _pickFromCamera,
                            child: CustomSvgIcon(
                              Assets.icons.cameraIcon,
                              size: 35.sp,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          GestureDetector(
                            onTap: _pickFromGallery,
                            child: CustomSvgIcon(
                              Assets.icons.galleryIcon,
                              size: 35.sp,
                            ),
                          ),
                        ],
                      )
                    else
                      SizedBox(width: 0),

                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: postController,
                      builder: (context, value, child) {
                        final hasText = value.text.trim().isNotEmpty;

                        return Opacity(
                          opacity: hasText ? 1 : 0.3,
                          child: ActionButton(
                            onPressed: hasText
                                ? () {
                                    widget.cubit.createPost(
                                      CreatePostParams(
                                        content: postController.text.trim(),
                                        userId: AppConstant.userId,
                                        mediaFiles: selectedImages,
                                      ),
                                    );
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      selectedImages.clear();
                                      postController.clear();
                                    });
                                  }
                                : null,
                            height: 32.h,
                            width: 50.w,
                            backgroundColor: HexColor.fromHex("#006C5D"),
                            child: Center(
                              child: Text(
                                'Post',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
