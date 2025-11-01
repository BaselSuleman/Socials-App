import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'loading_banner.dart';

class LoadingPanel extends StatelessWidget {
  const LoadingPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoadingBanner(size: 100),
            const SizedBox(height: 20),
            Text(
              "Loading".tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
