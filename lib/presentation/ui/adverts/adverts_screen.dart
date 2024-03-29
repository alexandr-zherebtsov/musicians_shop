import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/advert_card.dart';
import 'package:musicians_shop/presentation/widgets/app_error_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_progress.dart';
import 'package:musicians_shop/presentation/widgets/app_tab_bar.dart';
import 'package:musicians_shop/shared/localization/keys.dart';

class AdvertsScreen extends StatefulWidget {
  final ResponsiveScreen screen;

  const AdvertsScreen({
    required this.screen,
    super.key,
  });

  @override
  State<AdvertsScreen> createState() => _AdvertsScreenState();
}

class _AdvertsScreenState extends State<AdvertsScreen>
    with TickerProviderStateMixin {
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
      init: Get.find<AdvertsController>(),
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
                  height: 46,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      child: AppTabBar(
                        screen: widget.screen,
                        tabs: tabs,
                        tabController: tabController,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      RefreshIndicator.adaptive(
                        onRefresh: controller.onInit,
                        child: controller.myAdverts.isEmpty
                            ? const AppErrorWidget(
                                title: StringsKeys.thereAreNoAdverts,
                              )
                            : ListView.builder(
                                itemCount: controller.myAdverts.length,
                                itemBuilder: (_, int i) {
                                  return AdvertCard(
                                    screen: widget.screen,
                                    advert: controller.myAdverts[i],
                                    uid: controller.uid,
                                    onTapCard: () => controller
                                        .goToAdvert(controller.myAdverts[i]),
                                    onTapLike: () => controller.likeAdvert(
                                      advert: controller.myAdverts[i],
                                      my: true,
                                    ),
                                  );
                                },
                              ),
                      ),
                      RefreshIndicator.adaptive(
                        onRefresh: controller.onInit,
                        child: controller.likedAdverts.isEmpty
                            ? const AppErrorWidget(
                                title: StringsKeys.thereAreNoAdverts,
                              )
                            : ListView.builder(
                                itemCount: controller.likedAdverts.length,
                                itemBuilder: (_, int i) {
                                  return AdvertCard(
                                    screen: widget.screen,
                                    advert: controller.likedAdverts[i],
                                    uid: controller.uid,
                                    onTapCard: () => controller
                                        .goToAdvert(controller.likedAdverts[i]),
                                    onTapLike: () => controller.likeAdvert(
                                      advert: controller.likedAdverts[i],
                                      my: false,
                                    ),
                                  );
                                },
                              ),
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
