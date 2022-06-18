import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'package:musicians_shop/shared/widgets/app_network_image.dart';
import 'package:musicians_shop/shared/widgets/small_icon_button.dart';

class ProfileHeader extends StatelessWidget {
  final ResponsiveScreen screen;
  final String? userIcon;
  final String? firstName;
  final String? lastName;
  final String? city;
  final void Function()? onTapIcon;
  final void Function()? onTapEdit;

  const ProfileHeader({
    Key? key,
    required this.screen,
    required this.userIcon,
    required this.firstName,
    required this.lastName,
    required this.city,
    this.onTapIcon,
    this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screen.isDesktop ? const EdgeInsets.all(
        22,
      ) : const EdgeInsets.only(
        top: 22,
        left: 22,
        right: 4,
        bottom: 22,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTapIcon,
            child: Stack(
              children: [
                SizedBox(
                  width: screen.isDesktop ? 160 : 100,
                  height: screen.isDesktop ? 160 : 100,
                  child: ClipOval(
                    child: AppNetworkImage(
                      url: userIcon,
                      isPerson: true,
                      personSize: screen.isPhone ? 60 : 80,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Offstage(
                    offstage: onTapIcon == null,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: screen.isDesktop ? const EdgeInsets.only(
                top: 20,
                left: 12,
                right: 2,
              ) : const EdgeInsets.only(
                top: 10,
                left: 12,
                right: 2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getClearName(firstName, lastName),
                    style: Get.textTheme.headline3,
                    softWrap: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Offstage(
                      offstage: (city ?? '').isEmpty,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 2,
                              right: 2,
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 14,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              city ?? '',
                              style: Get.textTheme.bodyText1,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Offstage(
            offstage: onTapEdit == null,
            child: SmallIconButton(
              icon: Icons.edit,
              message: StringsKeys.edit.tr,
              onPressed: onTapEdit,
            ),
          ),
        ],
      ),
    );
  }
}
