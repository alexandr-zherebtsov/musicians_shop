import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/dropdown_widgets.dart';
import 'package:musicians_shop/shared/widgets/small_icon_button.dart';

class SelectedFieldWidget extends StatelessWidget {
  final String? title;
  final void Function() delete;

  const SelectedFieldWidget({
    Key? key,
    required this.title,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: title == null,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropDownFrame(
              margin: const EdgeInsets.only(
                left: 22,
                right: 4,
              ),
              child: Text(
                title ?? '',
                style: Get.theme.textTheme.subtitle1,
              ),
            ),
            SmallIconButton(
              icon: Icons.delete_outline,
              message: StringsKeys.delete.tr,
              onPressed: delete,
            ),
          ],
        ),
      ),
    );
  }
}
