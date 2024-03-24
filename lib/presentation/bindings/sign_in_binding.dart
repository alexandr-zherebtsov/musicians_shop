import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/remote/auth/auth_data_provider.dart';
import 'package:musicians_shop/data/remote/auth/auth_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/presentation/ui/auth/sign_in/sign_in_controller.dart';

class SignInBinding extends Bindings {
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
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
  }
}
