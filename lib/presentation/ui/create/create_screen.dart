import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/continue_button.dart';
import 'package:musicians_shop/presentation/ui/create/create_controller.dart';
import 'package:musicians_shop/presentation/ui/create/widgets/create_add_button.dart';
import 'package:musicians_shop/presentation/ui/create/widgets/create_image_widget.dart';
import 'package:musicians_shop/shared/constants/reg_exp.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';

class CreateScreen extends GetResponsiveView<CreateController> {
  CreateScreen({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return GetBuilder<CreateController>(
      autoRemove: false,
      builder: (_) {
        if (controller.screenLoader) {
          return ColoredBox(
            color: Get.theme.scaffoldBackgroundColor,
            child: const AppProgress(),
          );
        } else {
          return GestureDetector(
            onTap: controller.unFocus,
            child: Scaffold(
              appBar: AppBarWidget(
                title: controller.editableAdvert == null ? StringsKeys.create.tr : StringsKeys.edit.tr,
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: AppStyles.constraints,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextField(
                                      controller: controller.headlineTC,
                                      hint: StringsKeys.headline.tr,
                                      maxLines: 1,
                                      onSubmitted: (_) => controller.save(),
                                    ),
                                    AppTextField(
                                      controller: controller.priceTC,
                                      hint: StringsKeys.price.tr,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 22,
                                        right: 22,
                                        bottom: 30,
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(20),
                                        FilteringTextInputFormatter.allow(AppRegExp.priceRegExp),
                                      ],
                                      onSubmitted: (_) => controller.save(),
                                    ),
                                    AppTextField(
                                      controller: controller.descriptionTC,
                                      hint: StringsKeys.description.tr,
                                      maxLines: null,
                                      contentPadding: const EdgeInsets.all(12),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(4000),
                                      ],
                                      onSubmitted: (_) => controller.save(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 26,
                                        bottom: 10
                                      ),
                                      child: Text(
                                        StringsKeys.photos.tr,
                                        style: Get.theme.textTheme.bodyText2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                      ),
                                      child: Wrap(
                                        children: [
                                          ...controller.acquisitionImages.map((e) {
                                            return CreateImageWidget(
                                              image: e,
                                              fileType: FileTypeEnums.network,
                                              screen: screen,
                                              remove: () => controller.removeAcquisition(e),
                                            );
                                          }).toList(),
                                          ...controller.selectedImages.map((e) {
                                            return CreateImageWidget(
                                              image: e.path,
                                              fileType: FileTypeEnums.file,
                                              screen: screen,
                                              remove: () => controller.removeSelected(e),
                                            );
                                          }).toList(),
                                          Offstage(
                                            offstage: (controller.acquisitionImages.length + controller.selectedImages.length) > 4,
                                            child: CreateAddButton(
                                              screen: screen,
                                              onPressed: controller.addImage,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AuthContinueButton(
                        screen: screen,
                        title: StringsKeys.save.tr,
                        onTap: controller.save,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
