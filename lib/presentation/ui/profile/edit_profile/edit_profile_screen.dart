import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/brand_model.dart';
import 'package:musicians_shop/data/models/instrument_type_model.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/edit_profile_controller.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/widgets/selected_field_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_bar_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_button.dart';
import 'package:musicians_shop/presentation/widgets/app_error_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_field_header.dart';
import 'package:musicians_shop/presentation/widgets/app_progress.dart';
import 'package:musicians_shop/presentation/widgets/app_text_field.dart';
import 'package:musicians_shop/presentation/widgets/dropdown_icon.dart';
import 'package:musicians_shop/presentation/widgets/dropdown_widgets.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/values/reg_exp.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.unFocus,
      child: Scaffold(
        appBar: AppBarWidget(
          title: StringsKeys.editProfile.tr,
          back: Get.back,
        ),
        body: GetBuilder<EditProfileController>(
          autoRemove: false,
          builder: (_) {
            if (controller.screenLoader) {
              return const AppProgress();
            } else if (controller.screenError) {
              return const AppErrorWidget();
            } else {
              return _EditProfileBody(
                controller: controller,
              );
            }
          },
        ),
      ),
    );
  }
}

class _EditProfileBody extends StatelessWidget {
  final EditProfileController controller;

  const _EditProfileBody({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
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
                          header: StringsKeys.firstName,
                        ),
                        AppTextField(
                          controller: controller.firstNameTC,
                          hint: StringsKeys.firstName.tr,
                          maxLines: 1,
                          onSubmitted: (_) => controller.save(),
                        ),
                        const AppFieldHeader(
                          header: StringsKeys.lastName,
                        ),
                        AppTextField(
                          controller: controller.lastNameTC,
                          hint: StringsKeys.lastName.tr,
                          maxLines: 1,
                          onSubmitted: (_) => controller.save(),
                        ),
                        const AppFieldHeader(
                          header: StringsKeys.phoneNumber,
                        ),
                        AppTextField(
                          controller: controller.phoneNumberTC,
                          hint: StringsKeys.phoneNumber.tr,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          prefix: '+',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                            FilteringTextInputFormatter.allow(
                              AppRegExp.numRegExp,
                            ),
                          ],
                          onSubmitted: (_) => controller.save(),
                        ),
                        const AppFieldHeader(
                          header: StringsKeys.city,
                        ),
                        AppTextField(
                          controller: controller.cityTC,
                          hint: StringsKeys.city.tr,
                          maxLines: 1,
                          onSubmitted: (_) => controller.save(),
                        ),
                        const AppFieldHeader(
                          header: StringsKeys.aboutYourself,
                        ),
                        AppTextField(
                          controller: controller.aboutYourselfTC,
                          hint: StringsKeys.aboutYourself.tr,
                          maxLines: null,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2000),
                          ],
                          contentPadding: const EdgeInsets.all(12),
                          onSubmitted: (_) => controller.save(),
                        ),
                        const AppFieldHeader(
                          header: StringsKeys.favoriteInstruments,
                        ),
                        ...controller.favoriteInstruments.map(
                          (e) => SelectedFieldWidget(
                            title: e.type?.tr,
                            delete: () =>
                                controller.deleteFavoriteInstrumentType(e),
                          ),
                        ),
                        DropDownFrame(
                          child: DropdownButton<InstrumentTypeModel>(
                            isExpanded: true,
                            onChanged: (InstrumentTypeModel? v) =>
                                controller.addFavoriteInstrumentType(v),
                            underline: const Offstage(),
                            hint: const DropDownHint(
                              hint: StringsKeys.type,
                            ),
                            icon: const DropDownIcon(),
                            borderRadius:
                                BorderRadius.circular(AppStyles.fieldRadius),
                            dropdownColor: Get.theme.dialogBackgroundColor,
                            items: controller.instrumentTypes
                                .map<DropdownMenuItem<InstrumentTypeModel>>(
                                    (InstrumentTypeModel value) {
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
                          header: StringsKeys.favoriteBrands,
                        ),
                        ...controller.favoriteBrands
                            .map((e) => SelectedFieldWidget(
                                  title: e.name,
                                  delete: () =>
                                      controller.deleteFavoriteBrand(e),
                                )),
                        DropDownFrame(
                          child: DropdownButton<BrandModel>(
                            isExpanded: true,
                            onChanged: (BrandModel? v) =>
                                controller.addFavoriteBrand(v),
                            underline: const Offstage(),
                            hint: const DropDownHint(
                              hint: StringsKeys.brand,
                            ),
                            icon: const DropDownIcon(),
                            borderRadius:
                                BorderRadius.circular(AppStyles.fieldRadius),
                            dropdownColor: Get.theme.dialogBackgroundColor,
                            items: controller.brands
                                .map<DropdownMenuItem<BrandModel>>(
                                    (BrandModel value) {
                              return DropdownMenuItem<BrandModel>(
                                value: value,
                                child: DropDownItem(
                                  name: value.name,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: AppStyles.constraints,
                  child: AppButton(
                    title: StringsKeys.save.tr,
                    onTap: controller.save,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
