import 'package:get/get.dart';
import 'package:musicians_shop/shared/localization/languages/en.dart';
import 'package:musicians_shop/shared/localization/languages/uk.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        AppValues.langCodeEN: en,
        AppValues.langCodeUK: uk,
      };
}
