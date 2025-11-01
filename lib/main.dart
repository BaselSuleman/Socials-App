import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app.dart';
import 'core/presentation/widgets/custom_timeago_widget.dart';
import 'core/utils/app_bloc_observer.dart';
import 'di/injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  timeago.setLocaleMessages('en', MyCustomMessages());

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: App()),
  );
}

