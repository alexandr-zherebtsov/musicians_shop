import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';

abstract interface class IHandleErrorsDataProvider extends BaseDataProvider {
  Future<bool> handleError({
    required final Object error,
    required final StackTrace stackTrace,
    required final String name,
  });
}

final class HandleErrorsDataProvider implements IHandleErrorsDataProvider {
  HandleErrorsDataProvider({
    required final FirebaseCrashlytics crashlytics,
  }) : _crashlytics = crashlytics;

  final FirebaseCrashlytics _crashlytics;

  @override
  Future<bool> handleError({
    required final Object error,
    required final StackTrace stackTrace,
    required final String name,
  }) async {
    log(
      error.toString(),
      name: 'ERROR: $name',
      stackTrace: stackTrace,
    );
    if (!kIsWeb) {
      await _crashlytics.recordError(
        name,
        stackTrace,
        reason: name,
      );
    }
    return true;
  }
}
