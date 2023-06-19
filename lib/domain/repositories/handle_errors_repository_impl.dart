import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';

class HandleErrorsRepositoryImpl extends HandleErrorsRepository {
  final FirebaseCrashlytics _fcr;

  HandleErrorsRepositoryImpl(
    this._fcr,
  );

  @override
  Future<bool> handleError({
    required Object error,
    required StackTrace stackTrace,
    required String name,
  }) async {
    log(
      error.toString(),
      name: 'ERROR: $name',
      stackTrace: stackTrace,
    );
    if (!kIsWeb) {
      await _fcr.recordError(
        name,
        stackTrace,
        reason: name,
      );
    }
    return true;
  }
}
