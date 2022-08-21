import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote_repositories/adverts_repository.dart';
import 'package:musicians_shop/data/remote_repositories/handle_errors_repository.dart';
import 'package:musicians_shop/domain/repositories/adverts_repository_impl.dart';
import 'package:musicians_shop/data/remote_repositories/auth_repository.dart';
import 'package:musicians_shop/domain/repositories/auth_repository_impl.dart';
import 'package:musicians_shop/data/remote_repositories/file_repository.dart';
import 'package:musicians_shop/domain/repositories/file_repository_impl.dart';
import 'package:musicians_shop/data/remote_repositories/push_notification_repository.dart';
import 'package:musicians_shop/domain/repositories/push_notification_repository_impl.dart';
import 'package:musicians_shop/data/remote_repositories/user_repository.dart';
import 'package:musicians_shop/domain/repositories/user_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        FirebaseAuth.instance,
        FirebaseAnalytics.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<PushNotificationRepository>(
      () => PushNotificationRepositoryImpl(
        Get.find<Logger>(),
        FirebaseMessaging.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find<Logger>(),
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<FileRepository>(
      () => FileRepositoryImpl(
        FirebaseStorage.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AdvertsRepository>(
      () => AdvertsRepositoryImpl(
        Get.find<Logger>(),
        FirebaseFirestore.instance,
        FirebaseAnalytics.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<MyProfileController>(
      () => MyProfileController(
        Get.find<AuthRepository>(),
        Get.find<UserRepository>(),
        Get.find<FileRepository>(),
        Get.find<AdvertsRepository>(),
        FirebaseMessaging.instance,
      ),
    );
  }
}
