import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/create/create_controller.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
      init: CreateController(),
      builder: (CreateController controller) {
        return Scaffold(
          appBar: AppBarWidget(
            title: StringsKeys.create.tr,
          ),
          body: const Center(
            child: Text('Create'),
          ),
        );
      },
    );
  }
}
