import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_assessment/core/presentation/widgets/svg_icon.dart';
import 'package:micropolis_assessment/core/utils/extentions.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/cubits/socials/socials_cubit.dart';
import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/custom_toast.dart';
import '../widgets/create_post_widget.dart';
import '../widgets/latest_posts_tab_widget.dart';
import '../widgets/my_posts_tab_widget.dart';
import '../widgets/socials_app_bar_widget.dart';
import '../widgets/stories_widget.dart';

class SocialsPage extends StatefulWidget {
  const SocialsPage({super.key});

  @override
  State<SocialsPage> createState() => _SocialsPageState();
}

class _SocialsPageState extends State<SocialsPage>
    with SingleTickerProviderStateMixin {
  late final SocialsPageCubit cubit;
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    cubit = SocialsPageCubit();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void changeTheTab() {
    if (_currentIndex == 0) {
      _tabController.animateTo(1);
    } else {
      _tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialsPageCubit, SocialsPageState>(
      bloc: cubit,

      builder: (context, state) {
        return Scaffold(
          appBar: SocialsAppBarWidget(),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      StoriesWidget(),
                      Divider(color: HexColor.fromHex("#DBDBDB"), thickness: 2),
                      CreatePostWidget(cubit: cubit),
                      Divider(color: HexColor.fromHex("#DBDBDB"), thickness: 1),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarHeaderDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey[600],
                      indicatorColor: HexColor.fromHex("#2E7D32"),
                      indicatorPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 4,
                      padding: EdgeInsets.symmetric(horizontal: 80.w),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      tabs: const [
                        Tab(text: "Latest"),
                        Tab(text: "My posts"),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                LatestPostsTab(cubit: cubit),
                MyPostsTab(cubit: cubit),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.status == SocialsPageStatus.createPostLoading) {
          CustomToast.show(
            context: context,
            duration: Duration(seconds: 10),
            message: "Posting...",
            icon: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            ),
          );
        }
        if (state.status == SocialsPageStatus.createPostSuccess) {
          cubit.getUserPost(withRefresh: true);
          cubit.userPaginationCubit.load(false);
          CustomToast.show(
            context: context,
            duration: Duration(seconds: 5),
            message: "Post submitted – pending approval",
            icon: CustomSvgIcon(Assets.icons.checkIcon),
            onTap: () {
              changeTheTab();
            },
          );
        }
        if (state.status == SocialsPageStatus.createPostError) {
          CustomToast.show(
            context: context,
            duration: Duration(seconds: 5),
            message: "Some Thing Went Wrong!",
            icon: CustomSvgIcon(Assets.icons.rejectedIcon, color: Colors.red),
          );
        }
      },
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarHeaderDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          tabBar,
          Positioned(
            bottom: -7.5.h,
            left: 0,
            right: 0,
            child: Divider(color: HexColor.fromHex("#DBDBDB"), thickness: 1),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) => false;
}
