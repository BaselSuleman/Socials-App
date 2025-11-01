import 'package:flutter/material.dart';
import 'package:micropolis_assessment/features/mainPage/presentation/pages/socials_page.dart';

import '../widgets/custom_bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  final String section;

  const MainPage({super.key, required this.section});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 1;
  late final List<Widget> pages;

  @override
  void initState() {
    pages = [Container(), SocialsPage(), Container(), Container()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: pages[currentPageIndex]),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: CustomBottomNavBar(
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          currentIndex: currentPageIndex,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
