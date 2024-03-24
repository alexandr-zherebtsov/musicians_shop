import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/widgets/dropdown_widgets.dart';
import 'package:musicians_shop/presentation/widgets/small_icon_button.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class SelectedFieldWidget extends StatelessWidget {
  final String? title;
  final VoidCallback delete;

  const SelectedFieldWidget({
    required this.title,
    required this.delete,
    super.key,
  });

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
              ),
            ),
            SmallIconButton(
              icon: AppIcons.delete,
              message: StringsKeys.delete.tr,
              onPressed: delete,
            ),
          ],
        ),
      ),
    );
  }
}
