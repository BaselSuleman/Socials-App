import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:micropolis_assessment/router.dart';

import 'core/data/enums/auth_state.dart';
import 'core/presentation/blocs/authentication/authentication_cubit.dart';
import 'core/presentation/resources/theme/app_color_scheme.dart';
import 'core/presentation/resources/theme/app_theme.dart';
import 'di/injection.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  GoRouter router = getRouter(AuthState.authenticated);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => getIt<AuthenticationCubit>(),
        ),
      ],
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          switch (state.authState) {
            case AuthState.authenticated:
              break;
          }
          router = getRouter(state.authState);
        },
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(428, 926),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                routeInformationProvider: router.routeInformationProvider,
                routeInformationParser: router.routeInformationParser,
                routerDelegate: router.routerDelegate,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Assessment',
                theme: AppTheme(AppLightColorScheme()).getThemeData(context),
              );
            },
          );
        },
      ),
    );
  }
}
