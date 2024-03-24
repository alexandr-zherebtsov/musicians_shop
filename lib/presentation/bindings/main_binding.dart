import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/local/preference_manager.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_data_provider.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/remote/auth/auth_data_provider.dart';
import 'package:musicians_shop/data/remote/auth/auth_repository.dart';
import 'package:musicians_shop/data/remote/file/file_data_provider.dart';
import 'package:musicians_shop/data/remote/file/file_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote/push_notification/push_notification_data_provider.dart';
import 'package:musicians_shop/data/remote/push_notification/push_notification_repository.dart';
import 'package:musicians_shop/data/remote/user/user_data_provider.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_controller.dart';
import 'package:musicians_shop/presentation/ui/home/home_controller.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_controller.dart';
import 'package:musicians_shop/presentation/ui/statistic/statistic_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthRepository>(
      () => AuthRepository(
        dataProvider: AuthDataProvider(
          auth: FirebaseAuth.instance,
          analytics: FirebaseAnalytics.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<IPushNotificationRepository>(
      () => PushNotificationRepository(
        dataProvider: PushNotificationDataProvider(
          logger: Get.find<Logger>(),
          auth: FirebaseAuth.instance,
          messaging: FirebaseMessaging.instance,
          userRepository: Get.find<IUserRepository>(),
          pref: Get.find<IPreferenceManager>(),
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<IUserRepository>(
      () => UserRepository(
        dataProvider: UserDataProvider(
          logger: Get.find<Logger>(),
          auth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<IFileRepository>(
      () => FileRepository(
        dataProvider: FileDataProvider(
          storage: FirebaseStorage.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<IAdvertsRepository>(
      () => AdvertsRepository(
        dataProvider: AdvertsDataProvider(
          logger: Get.find<Logger>(),
          firestore: FirebaseFirestore.instance,
          analytics: FirebaseAnalytics.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<MyProfileController>(
      () => MyProfileController(
        Get.find<IAuthRepository>(),
        Get.find<IUserRepository>(),
        Get.find<IFileRepository>(),
        Get.find<IAdvertsRepository>(),
        Get.find<IPushNotificationRepository>(),
        Get.find<IPreferenceManager>(),
      ),
    );
    Get.lazyPut<MainController>(
      () => MainController(
        Get.find<IPushNotificationRepository>(),
      ),
    );
    Get.lazyPut<AdvertsController>(
      () => AdvertsController(
        Get.find<IAdvertsRepository>(),
      ),
    );
    Get.lazyPut<StatisticController>(
      () => StatisticController(
        Get.find<IUserRepository>(),
        Get.find<IAdvertsRepository>(),
      ),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<IUserRepository>(),
        Get.find<IAdvertsRepository>(),
      ),
    );
  }
}
