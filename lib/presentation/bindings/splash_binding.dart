import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote/user/user_data_provider.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/presentation/ui/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
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
    Get.put<SplashController>(
      SplashController(
        Get.find<IUserRepository>(),
      ),
    );
  }
}
