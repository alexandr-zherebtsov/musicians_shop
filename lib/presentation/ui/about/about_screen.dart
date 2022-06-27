import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/about/about_controller.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';

class AboutScreen extends GetResponsiveView<AboutController> {
  AboutScreen({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBarWidget(
        title: StringsKeys.about.tr,
        back: Get.back,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screen.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      StringsKeys.musiciansShop.tr,
                      style: Get.theme.textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Hero(
                    tag: AppValues.heroMusicNoteOutlined,
                    child: Icon(
                      AppIcons.musicNote,
                      color: Get.theme.primaryColor,
                      size: 160,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 6.0),
                    child: Text(
                      StringsKeys.createdBy.tr,
                      style: Get.theme.textTheme.bodyText1,
                    ),
                  ),
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      StringsKeys.appAuthor.tr,
                      style: Get.theme.textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => controller.launchTo(AppValues.gitHubUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            StringsKeys.usingFlutter.tr,
                            style: Get.theme.textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: FlutterLogo(size: 24),
                          ),
                        ],
                      ),
                      onTap: () => controller.launchTo(AppValues.flutterUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Obx(() => Text(
                      controller.version.value,
                      style: Get.theme.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
