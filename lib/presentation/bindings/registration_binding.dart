import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/remote/auth_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/domain/repositories/auth_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/auth/registration/registration_controller.dart';

class RegistrationBinding extends Bindings {
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
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
