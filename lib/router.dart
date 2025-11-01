import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micropolis_assessment/core/domain/domain/params/show_image_params.dart';
import 'package:micropolis_assessment/core/presentation/pages/show_image_page.dart';

import 'core/data/enums/auth_state.dart';
import 'features/mainPage/presentation/pages/main_page.dart';

abstract class AppPaths {
  static const main = _MainPaths();
  static const external = _ExternalPaths();
}

class _MainPaths {
  const _MainPaths();

  final String base = '/main';

  String get home => '$base/home';
}

class _ExternalPaths {
  const _ExternalPaths();

  final String showImage = '/showImage';
}

GoRouter getRouter(AuthState authState) {
  String initialPath = '/';

  switch (authState) {
    case AuthState.authenticated:
      initialPath = AppPaths.main.home;
      break;
  }

  return GoRouter(
    initialLocation: initialPath,
    routes: <GoRoute>[
      GoRoute(
        path: '${AppPaths.main.base}/:section',
        builder: (BuildContext context, GoRouterState state) {
          final section = state.pathParameters['section'] ?? 'home';
          return MainPage(section: '/main/$section');
        },
      ),
      GoRoute(
        path: AppPaths.external.showImage,
        builder: (BuildContext context, GoRouterState state) {
          final extras = state.extra as ShowImageParams;
          return ShowImagePage(showImageParams: extras);
        },
      ),
    ],
  );
}
