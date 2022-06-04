# Musicians Shop

### Platforms
```
1 - Android
2 - iOS
3 - Web
```

### Architecture
Project using GetX for communication between layers

![](readme/architecture.png)

### Libraries & Tools

- [Flutter 3.0.1 • channel stable](https://flutter.dev)
- [Dart 2.17.1](https://dart.dev)
- [DevTools 2.12.2](https://docs.flutter.dev/development/tools/devtools/overview)

Core
- [get](https://github.com/jonataslaw/getx)

Firebase
- [firebase_core](https://github.com/firebase/flutterfire/tree/master/packages/firebase_core/firebase_core)
- [firebase_auth](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth)
- [cloud_firestore](https://github.com/firebase/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore)
- [flutterfire_cli](https://github.com/invertase/flutterfire_cli)
- [firebase_storage](https://github.com/firebase/flutterfire/tree/master/packages/firebase_storage/firebase_storage)

UI
- [fluttertoast](https://github.com/PonnamKarthik/FlutterToast)
- [carousel_slider](https://github.com/serenader2014/flutter_carousel_slider)
- [cupertino_icons](https://github.com/flutter/packages/tree/master/third_party/packages/cupertino_icons)

Utils
- [mime](https://github.com/dart-lang/mime)
- [url_strategy](https://github.com/simpleclub/url_strategy)
- [url_launcher](https://github.com/flutter/plugins/tree/main/packages/url_launcher/url_launcher)
- [image_picker](https://github.com/flutter/plugins/tree/main/packages/image_picker/image_picker)
- [package_info_plus](https://github.com/fluttercommunity/plus_plugins/tree/main/packages)

Dev Dependencies
- [flutter_lints](https://github.com/flutter/packages/tree/main/packages/flutter_lints)
- [flutter_launcher_icons_maker](https://github.com/gsmlg-dev/flutter_launcher_icons_maker)

### Directory Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
|- web
```

Here is the folder structure we have been using in this project

```
lib/
|- data/
|- domain/
|- presentation/
|- shared/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- data - Contains the data layer of project, includes directories for local, network and shared pref/cache.
2- domain - Contains abstraction and business logic of project, includes models, responses, request, etc.
3- presentation - Contains all the ui of project, contains sub directory for each screen.
4- shared - Contains the utilities/common functions, styles of application.
5- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Main
This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:musicians_shop/presentation/bindings/global_binding.dart';
import 'package:musicians_shop/presentation/router/router.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/core/localization/translations.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setPathUrlStrategy();
    await Firebase.initializeApp(
      options: AppValues.firebaseOptions,
    );
    SystemNavigator.routeInformationUpdated(
      location: AppRoutes.splash,
    );
  } else {
    await Firebase.initializeApp();
  }
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
      theme: getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```