import 'package:get/get.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/core/localization/languages/en.dart';
import 'package:musicians_shop/shared/core/localization/languages/uk.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    AppValues.langCodeEN: en,
    AppValues.langCodeUK: uk,
  };
}
