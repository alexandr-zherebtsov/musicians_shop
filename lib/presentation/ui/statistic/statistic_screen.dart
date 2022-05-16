import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/statistic/statistic_controller.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticController>(
      init: StatisticController(),
      builder: (StatisticController controller) {
        return const Center(
          child: Text('Statistic'),
        );
      },
    );
  }
}
