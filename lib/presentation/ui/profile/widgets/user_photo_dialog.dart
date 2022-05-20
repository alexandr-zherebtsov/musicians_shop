import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/divider_widget.dart';

void showAvatarDialog({
  required bool isBottomSheet,
  required void Function() change,
  required void Function()? delete,
}) {
  isBottomSheet ? showAvatarBottomSheet(
    change: change,
    delete: delete,
  ) : showAvatarAlertDialog(
    change: change,
    delete: delete,
  );
}

void showAvatarAlertDialog({
  required void Function() change,
  required void Function()? delete,
}) {
  Get.dialog(
    AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
      ),
      content: UserPhotoDialog(
        change: change,
        delete: delete,
        dialog: true,
      ),
    ),
  );
}

void showAvatarBottomSheet({
  required void Function() change,
  required void Function()? delete,
}) {
  Get.bottomSheet(
    SingleChildScrollView(
      child: UserPhotoDialog(
        change: change,
        delete: delete,
        dialog: false,
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppStyles.fieldRadius),
        topRight: Radius.circular(AppStyles.fieldRadius),
      ),
    ),
    barrierColor: Colors.transparent,
    backgroundColor: Get.theme.backgroundColor,
  );
}

class UserPhotoDialog extends StatelessWidget {
  final void Function() change;
  final void Function()? delete;
  final bool dialog;

  const UserPhotoDialog({
    Key? key,
    required this.change,
    required this.delete,
    required this.dialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0, bottom: 8.0),
            child: Text(
              StringsKeys.changeAvatar.tr,
              style: Get.theme.textTheme.headline4,
            ),
          ),
          dialog ? const SizedBox(
            height: 10,
          ) : const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: DividerWidget(),
          ),
          Material(
            color: Colors.transparent,
            child: ListTile(
              onTap: change,
              leading: const Icon(
                Icons.add_a_photo_outlined,
                size: 20,
              ),
              title: Text(
                StringsKeys.newAvatar.tr,
                style: Get.theme.textTheme.bodyText1,
              ),
            ),
          ),
          Offstage(
            offstage: delete == null,
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                onTap: delete,
                leading: const Icon(
                  Icons.delete_outline,
                  size: 22,
                ),
                title: Text(
                  StringsKeys.deleteAvatar.tr,
                  style: Get.theme.textTheme.bodyText1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
