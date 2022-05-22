import 'package:get/get.dart';
import 'package:musicians_shop/presentation/bindings/about_binding.dart';
import 'package:musicians_shop/presentation/bindings/advert_binding.dart';
import 'package:musicians_shop/presentation/bindings/create_binding.dart';
import 'package:musicians_shop/presentation/bindings/edit_profile_binding.dart';
import 'package:musicians_shop/presentation/bindings/main_binding.dart';
import 'package:musicians_shop/presentation/bindings/registration_binding.dart';
import 'package:musicians_shop/presentation/bindings/sign_up_binding.dart';
import 'package:musicians_shop/presentation/bindings/splash_binding.dart';
import 'package:musicians_shop/presentation/bindings/start_binding.dart';
import 'package:musicians_shop/presentation/bindings/user_data_binding.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/about/about_screen.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_screen.dart';
import 'package:musicians_shop/presentation/ui/auth/registration/registration_screen.dart';
import 'package:musicians_shop/presentation/ui/auth/sign_up/sign_up_screen.dart';
import 'package:musicians_shop/presentation/ui/auth/start/start_screen.dart';
import 'package:musicians_shop/presentation/ui/auth/user_data/user_data_screen.dart';
import 'package:musicians_shop/presentation/ui/create/create_screen.dart';
import 'package:musicians_shop/presentation/ui/main/main_screen.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/edit_profile_screen.dart';
import 'package:musicians_shop/presentation/ui/splash/splash_screen.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class AppRouter {
  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.start,
      page: () => const StartScreen(),
      binding: StartBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => RegistrationScreen(),
      binding: RegistrationBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.userData,
      page: () => UserDataScreen(),
      binding: UserDataBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.create,
      page: () => CreateScreen(),
      binding: CreateBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.advert,
      page: () => const AdvertScreen(),
      binding: AdvertBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => AboutScreen(),
      binding: AboutBinding(),
      transition: _transition(),
    ),
  ];

  static Transition? _transition() => isNotMobile() ? Transition.fadeIn : null;
}
