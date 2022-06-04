import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/themes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:musicians_shop/presentation/bindings/global_binding.dart';
import 'package:musicians_shop/presentation/router/router.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/core/localization/translations.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setPathUrlStrategy();
    SystemNavigator.routeInformationUpdated(
      location: AppRoutes.splash,
    );
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      getPages: AppRouter.routes,
      initialRoute: AppRoutes.splash,
      title: StringsKeys.musicianShop.tr,
      initialBinding: GlobalBinding(),
      translations: Translation(),
      locale: Locale(getLangCode()),
      theme: AppThemes.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
