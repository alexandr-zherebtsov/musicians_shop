import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/advert_card.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';

class AdvertsScreen extends StatefulWidget {
  final ResponsiveScreen screen;

  const AdvertsScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  State<AdvertsScreen> createState() => _AdvertsScreenState();
}

class _AdvertsScreenState extends State<AdvertsScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  final List<Tab> tabs = <Tab>[
    Tab(text: StringsKeys.my.tr),
    Tab(text: StringsKeys.liked.tr),
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
    return GetBuilder<AdvertsController>(
      init: AdvertsController(),
      builder: (AdvertsController controller) {
        if (controller.screenLoader) {
          return const AppProgress();
        } else if (controller.screenError) {
          return const AppErrorWidget();
        } else {
          return SizedBox(
            height: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: Center(
                    child: TabBar(
                      tabs: tabs,
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      controller.myAdverts.isEmpty ? const AppErrorWidget(
                        title: StringsKeys.thereAreNoAdverts,
                      ) : ListView.builder(
                        itemCount: controller.myAdverts.length,
                        itemBuilder: (_, int i) {
                          return AdvertCard(
                            screen: widget.screen,
                            advert: controller.myAdverts[i],
                            uid: controller.uid,
                            onTapCard: () => controller.goToAdvert(controller.myAdverts[i]),
                            onTapLike: () => controller.likeAdvert(
                              advert: controller.myAdverts[i],
                              my: true,
                            ),
                          );
                        },
                      ),
                      controller.likedAdverts.isEmpty ? const AppErrorWidget(
                        title: StringsKeys.thereAreNoAdverts,
                      ) : ListView.builder(
                        itemCount: controller.likedAdverts.length,
                        itemBuilder: (_, int i) {
                          return AdvertCard(
                            screen: widget.screen,
                            advert: controller.likedAdverts[i],
                            uid: controller.uid,
                            onTapCard: () => controller.goToAdvert(controller.likedAdverts[i]),
                            onTapLike: () => controller.likeAdvert(
                              advert: controller.likedAdverts[i],
                              my: false,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
