import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/local/preference_manager.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_data_provider.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';

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
    Get.lazyPut<IPreferenceManager>(
      () => PreferenceManager(),
      fenix: true,
    );
    Get.lazyPut<IHandleErrorsRepository>(
      () => HandleErrorsRepository(
        dataProvider: HandleErrorsDataProvider(
          crashlytics: FirebaseCrashlytics.instance,
        ),
      ),
      fenix: true,
    );
  }
}
