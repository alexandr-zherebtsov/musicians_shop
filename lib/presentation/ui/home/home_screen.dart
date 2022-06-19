import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/home/home_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/advert_card.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';

class HomeScreen extends StatelessWidget {
  final ResponsiveScreen screen;

  const HomeScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        if (controller.screenLoader) {
          return const AppProgress();
        } else if (controller.screenError) {
          return const AppErrorWidget();
        } else if (controller.adverts.isEmpty) {
          return const AppErrorWidget(
            title: StringsKeys.thereAreNoAdverts,
          );
        } else {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                AppTextField(
                  maxLines: 1,
                  hint: StringsKeys.search.tr,
                  controller: controller.searchTC,
                  suffixIcon: Icons.search,
                  padding: screen.isPhone ? const EdgeInsets.only(
                    top: 6.0,
                    left: 12.0,
                    right: 12.0,
                    bottom: 6.0,
                  ) : const EdgeInsets.only(
                    top: 14.0,
                    left: 28.0,
                    right: 28.0,
                    bottom: 8.0,
                  ),
                  onChanged: (_) => controller.searchFunc(),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.onInit,
                    child: Builder(
                      builder: (_) {
                        if (controller.activeSearch) {
                          return controller.searchedAdverts.isEmpty ? const AppErrorWidget(
                            title: StringsKeys.noSearchResults,
                          ) : ListView.builder(
                            itemCount: controller.searchedAdverts.length,
                            itemBuilder: (_, int i) {
                              return AdvertCard(
                                screen: screen,
                                advert: controller.searchedAdverts[i],
                                uid: controller.uid,
                                onTapCard: () => controller.goToAdvert(controller.searchedAdverts[i]),
                                onTapLike: () => controller.likeAdvert(controller.searchedAdverts[i]),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            itemCount: controller.adverts.length,
                            itemBuilder: (_, int i) {
                              return AdvertCard(
                                screen: screen,
                                advert: controller.adverts[i],
                                uid: controller.uid,
                                onTapCard: () => controller.goToAdvert(controller.adverts[i]),
                                onTapLike: () => controller.likeAdvert(controller.adverts[i]),
                              );
                            },
                          );
                        }
                      },
                    ),
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
