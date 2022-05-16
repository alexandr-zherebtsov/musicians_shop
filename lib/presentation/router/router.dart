import 'package:get/get.dart';
import 'package:musicians_shop/presentation/bindings/about_binding.dart';
import 'package:musicians_shop/presentation/bindings/create_binding.dart';
import 'package:musicians_shop/presentation/bindings/main_binding.dart';
import 'package:musicians_shop/presentation/bindings/splash_binding.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/about/about_screen.dart';
import 'package:musicians_shop/presentation/ui/create/create_screen.dart';
import 'package:musicians_shop/presentation/ui/main/main_screen.dart';
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
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.create,
      page: () => const CreateScreen(),
      binding: CreateBinding(),
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
