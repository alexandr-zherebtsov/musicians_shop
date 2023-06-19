import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/continue_button.dart';
import 'package:musicians_shop/presentation/ui/create/create_controller.dart';
import 'package:musicians_shop/presentation/ui/create/widgets/create_add_button.dart';
import 'package:musicians_shop/presentation/ui/create/widgets/create_image_widget.dart';
import 'package:musicians_shop/shared/constants/reg_exp.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';
import 'package:musicians_shop/shared/widgets/app_field_header.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';
import 'package:musicians_shop/shared/widgets/dropdown_icon.dart';
import 'package:musicians_shop/shared/widgets/dropdown_widgets.dart';

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
                back: Get.back,
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: AppStyles.constraints,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 98,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppFieldHeader(
                                    header: StringsKeys.headline,
                                  ),
                                  AppTextField(
                                    controller: controller.headlineTC,
                                    hint: StringsKeys.headline.tr,
                                    maxLines: 1,
                                    onSubmitted: (_) => controller.save(),
                                  ),
                                  const AppFieldHeader(
                                    header: StringsKeys.price,
                                  ),
                                  AppTextField(
                                    controller: controller.priceTC,
                                    hint: StringsKeys.price.tr,
                                    maxLines: 1,
                                    prefix: '\$',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20),
                                      FilteringTextInputFormatter.allow(AppRegExp.priceRegExp),
                                    ],
                                    onSubmitted: (_) => controller.save(),
                                  ),
                                  const AppFieldHeader(
                                    header: StringsKeys.description,
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
                                  const AppFieldHeader(
                                    header: StringsKeys.typeOfMusicalInstrument,
                                  ),
                                  DropDownFrame(
                                    child: DropdownButton<InstrumentTypeModel>(
                                      isExpanded: true,
                                      value: controller.instrumentType,
                                      onChanged: (InstrumentTypeModel? v) => controller.instrumentType = v,
                                      underline: const Offstage(),
                                      hint: const DropDownHint(
                                        hint: StringsKeys.type,
                                      ),
                                      icon: const DropDownIcon(),
                                      borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
                                      dropdownColor: Get.theme.dialogBackgroundColor,
                                      items: controller.instrumentTypes.map<DropdownMenuItem<InstrumentTypeModel>>((InstrumentTypeModel value) {
                                        return DropdownMenuItem<InstrumentTypeModel>(
                                          value: value,
                                          child: DropDownItem(
                                            name: value.type,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const AppFieldHeader(
                                    header: StringsKeys.brand,
                                  ),
                                  DropDownFrame(
                                    child: DropdownButton<BrandModel>(
                                      isExpanded: true,
                                      value: controller.brand,
                                      onChanged: (BrandModel? v) => controller.brand = v,
                                      underline: const Offstage(),
                                      hint: const DropDownHint(
                                        hint: StringsKeys.brand,
                                      ),
                                      icon: const DropDownIcon(),
                                      borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
                                      dropdownColor: Get.theme.dialogBackgroundColor,
                                      items: controller.brands.map<DropdownMenuItem<BrandModel>>((BrandModel value) {
                                        return DropdownMenuItem<BrandModel>(
                                          value: value,
                                          child: DropDownItem(
                                            name: value.name,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const AppFieldHeader(
                                    header: StringsKeys.photos,
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
                                            image: kIsWeb ? '' : e.path ?? '',
                                            bytes: e.bytes,
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
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: MainContinueButton(
                          screen: screen,
                          title: StringsKeys.save.tr,
                          onTap: controller.save,
                        ),
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
