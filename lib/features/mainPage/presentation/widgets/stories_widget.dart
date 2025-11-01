import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:micropolis_assessment/core/domain/domain/params/show_image_params.dart';
import 'package:micropolis_assessment/core/presentation/widgets/network_image.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/story_model.dart';
import 'package:micropolis_assessment/router.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/utils/app_constants.dart';

class StoriesWidget extends StatefulWidget {
  final List<StoryModel> initialStories;

  StoriesWidget({super.key, List<StoryModel>? initialStories})
    : initialStories =
          initialStories ??
          [
            StoryModel.own(
              id: 'own_01',
              imageUrl: AppConstant.profileTempImage,
              hasNewStory: false,
            ),
            StoryModel(
              id: 'HQJRTWNNVCLZOBV6_01',
              name: 'HQJRTWNNVCLZOBV6',
              imageUrl:
                  'https://i.ibb.co/YF3MzTC4/MHQJRTWNNVCLZOBV6-DFDXJ6-TL4.jpg',
              hasNewStory: true,
            ),
            StoryModel(
              id: 'BO33-NIN75-HOBFERE52',
              name: 'BO33-NIN75-HOBFERE52',
              imageUrl:
                  'https://i.ibb.co/4RDXfYqc/2-BO33-NIN75-HOBFERE5-WUYAFRLA.jpg',
              hasNewStory: true,
            ),
            StoryModel(
              id: 'micropolis_01',
              name: 'Micropolis Robtics micropolis',
              imageUrl:
                  'https://i.ibb.co/nHRsCrd/3e294d91aab1821bcff9d95feedf9ad971056c1f.jpg',
              hasNewStory: true,
            ),

            StoryModel(
              id: 'BO33-NIN75-HOBFERE5',
              name: 'BO33-NIN75-HOBFERE5',
              imageUrl:
                  'https://i.ibb.co/4RDXfYqc/2-BO33-NIN75-HOBFERE5-WUYAFRLA.jpg',
              hasNewStory: false,
            ),
          ];

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  late List<StoryModel> _stories;

  @override
  void initState() {
    super.initState();
    _stories = List<StoryModel>.from(widget.initialStories);
  }

  void _onStoryTap(int index) {
    final story = _stories[index];
    if (story.hasNewStory) {
      setState(() {
        _stories[index] = story.copyWith(hasNewStory: false);
      });
    }
    context.push(
      AppPaths.external.showImage,
      extra: ShowImageParams(imageUrl: story.imageUrl, isStatus: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: SizedBox(
        height: 120.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _stories.length,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final story = _stories[index];
            if (story.isOwnStory) {
              return MyStoryWidget(
                key: ValueKey(story.id),
                imageUrl: story.imageUrl.trim(),
                onPressed: () {},
              );
            } else {
              return StoryItem(
                key: ValueKey(story.id),
                name: story.name,
                imageUrl: story.imageUrl.trim(),
                hasNewStory: story.hasNewStory,
                onTap: () => _onStoryTap(index),
              );
            }
          },
        ),
      ),
    );
  }
}

class MyStoryWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String? imageUrl;
  final double? height;
  final double? width;
  final bool seeTitle;

  const MyStoryWidget({
    super.key,
    required this.onPressed,
    this.imageUrl,
    this.height,
    this.width,
    this.seeTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: width ?? 80.w,
                height: height ?? 80.h,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: CustomNetworkImage(
                      url: (imageUrl ?? "").trim(),
                      borderRadius: BorderRadius.circular(40),
                      boxFit: BoxFit.cover,
                      errorIcon: Assets.icons.personIcon,
                    ),
                  ),
                ),
              ),
              if (seeTitle)
                PositionedDirectional(
                  bottom: 2.w,
                  end: 0.w,
                  child: Container(
                    width: 25.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#DF7939"),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                ),
            ],
          ),
          if (seeTitle) ...[
            SizedBox(height: 10.h),
            Text(
              'Your Story',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool hasNewStory;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.hasNewStory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.all(3.sp),
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: hasNewStory
                  ? Border.all(color: HexColor.fromHex("#DF7939"), width: 3)
                  : null,
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CustomNetworkImage(
                url: imageUrl.trim(),
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: 60.w,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
