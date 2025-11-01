import 'package:flutter/cupertino.dart';

import '../failures/base_failure.dart';
import '../failures/http/http_failure.dart';
import 'http_failure_parser/http_failure_parser.dart';

class FailureParser {
  static String mapFailureToString({
    required Failure failure,
    required BuildContext context,
  }) {
    if (failure is HttpFailure) {
      return HttpFailureParser.mapHttpFailureToErrorMessage(failure);
    } else {
      return "unknown error";
    }
  }
}
