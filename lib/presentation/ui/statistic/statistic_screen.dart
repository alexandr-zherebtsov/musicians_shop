import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/presentation/ui/statistic/statistic_controller.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_tab_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticScreen extends StatelessWidget {
  final ResponsiveScreen screen;

  const StatisticScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticController>(
      init: StatisticController(),
      builder: (StatisticController controller) {
        if (controller.screenLoader) {
          return const AppProgress();
        } else if (controller.screenError) {
          return const AppErrorWidget();
        } else {
          return _StatisticScreen(
            screen: screen,
            controller: controller,
          );
        }
      },
    );
  }
}

class _StatisticScreen extends StatefulWidget {
  final ResponsiveScreen screen;
  final StatisticController controller;

  const _StatisticScreen({
    Key? key,
    required this.screen,
    required this.controller,
  }) : super(key: key);

  @override
  State<_StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<_StatisticScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  final List<Tab> tabs = <Tab>[
    Tab(text: StringsKeys.likes.tr),
    Tab(text: StringsKeys.recommendations.tr),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: <Widget>[
          AppTabBar(
            screen: widget.screen,
            tabs: tabs,
            tabController: tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                widget.controller.myAdverts.isEmpty ? const AppErrorWidget(
                  title: StringsKeys.thereAreNoAdverts,
                ) : widget.controller.noLikes ? const AppErrorWidget(
                  title: StringsKeys.thereAreNoLikes,
                ) : SfCartesianChart(
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
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppStyles.fieldRadius),
                        topRight: Radius.circular(AppStyles.fieldRadius),
                      ),
                      onPointTap: (ChartPointDetails e) => widget.controller.goToAdvert(e.pointIndex),
                      dataSource: widget.controller.myAdverts,
                      xValueMapper: (AdvertModel e, _) => e.headline ?? '',
                      yValueMapper: (AdvertModel e, _) => e.likes?.length ?? 0,
                    ),
                  ],
                ),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  ),
                  primaryYAxis: NumericAxis(
                  ),
                  series: <LineSeries<AdvertModel, String>>[
                    LineSeries<AdvertModel, String>(
                      color: Get.theme.primaryColor,
                      dataSource: widget.controller.statisticAdverts,
                      xValueMapper: (AdvertModel e, _) => getGraphDateLabel(e.createdAt?.toDate()),
                      yValueMapper: (AdvertModel e, _) => e.userCount ?? 0,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
