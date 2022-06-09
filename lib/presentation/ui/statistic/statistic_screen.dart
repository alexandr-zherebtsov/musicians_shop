import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/presentation/ui/statistic/statistic_controller.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticController>(
      init: StatisticController(),
      builder: (StatisticController controller) {
        if (controller.screenLoader) {
          return const AppProgress();
        } else if (controller.myAdverts.isEmpty) {
          return const AppErrorWidget(
            title: StringsKeys.thereAreNoAdverts,
          );
        } else {
          return SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              axisLine: const AxisLine(width: 1),
              majorGridLines: const MajorGridLines(width: 0),
              labelIntersectAction: AxisLabelIntersectAction.multipleRows,
            ),
            primaryYAxis: NumericAxis(
              interval: 1,
              axisLine: const AxisLine(width: 1),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            series: <ColumnSeries<AdvertModel, String>>[
              ColumnSeries<AdvertModel, String>(
                color: Get.theme.primaryColor,
                animationDelay: 1,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppStyles.fieldRadius),
                  topRight: Radius.circular(AppStyles.fieldRadius),
                ),
                onPointTap: (ChartPointDetails e) => controller.goToAdvert(e.pointIndex),
                dataSource: controller.myAdverts,
                xValueMapper: (AdvertModel e, _) => e.headline ?? '',
                yValueMapper: (AdvertModel e, _) => e.likes?.length ?? 0,
              ),
            ],
          );
        }
      },
    );
  }
}
