import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/local/preference_manager.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/domain/repositories/handle_errors_repository_impl.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Logger>(
      () => Logger(
        printer: PrettyPrinter(
          printEmojis: false,
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<PreferenceManager>(
      () => PreferenceManager(),
      fenix: true,
    );
    Get.lazyPut<HandleErrorsRepository>(
      () => HandleErrorsRepositoryImpl(
        FirebaseCrashlytics.instance,
      ),
      fenix: true,
    );
  }
}
