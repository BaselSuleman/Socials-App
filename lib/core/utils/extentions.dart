import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:micropolis_assessment/core/utils/parse_helpers/failure_parser.dart';

import 'failures/base_failure.dart';

extension ContextMethods on BuildContext {
  String failureParser(Failure failure) =>
      FailureParser.mapFailureToString(failure: failure, context: this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;


  bool get isArabic => locale.languageCode == 'ar';
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
