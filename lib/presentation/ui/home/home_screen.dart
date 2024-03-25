import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/presentation/ui/home/home_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/advert_card.dart';
import 'package:musicians_shop/presentation/widgets/app_error_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_progress.dart';
import 'package:musicians_shop/presentation/widgets/app_text_field.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class HomeScreen extends StatelessWidget {
  final ResponsiveScreen screen;

  const HomeScreen({
    required this.screen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
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
                  suffixIcon: AppIcons.search,
                  padding: screen.isPhone
                      ? const EdgeInsets.only(
                          top: 6,
                          left: 12,
                          right: 12,
                          bottom: 6,
                        )
                      : const EdgeInsets.only(
                          top: 14,
                          left: 28,
                          right: 28,
                          bottom: 8,
                        ),
                  onChanged: (_) => controller.searchFunc(),
                ),
                Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: controller.onInit,
                    child: Builder(
                      builder: (_) {
                        if (controller.activeSearch) {
                          return controller.searchedAdverts.isEmpty
                              ? const AppErrorWidget(
                                  title: StringsKeys.noSearchResults,
                                )
                              : ListView.builder(
                                  itemCount: controller.searchedAdverts.length,
                                  itemBuilder: (_, int i) {
                                    return AdvertCard(
                                      screen: screen,
                                      advert: controller.searchedAdverts[i],
                                      uid: controller.uid,
                                      onTapCard: () => controller.goToAdvert(
                                        controller.searchedAdverts[i],
                                      ),
                                      onTapLike: () => controller.likeAdvert(
                                        controller.searchedAdverts[i],
                                      ),
                                    );
                                  },
                                );
                        } else {
                          return _AdvertsView(
                            screen: screen,
                            controller: controller,
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

class _AdvertsView extends StatelessWidget {
  final ResponsiveScreen screen;
  final HomeController controller;

  const _AdvertsView({
    required this.screen,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.streamAdverts,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      ) {
        if (snapshot.hasData) {
          if ((snapshot.data?.docs ?? []).isEmpty) {
            return const AppErrorWidget(
              title: StringsKeys.thereAreNoAdverts,
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (_, int i) {
              final AdvertModel? advert = AdvertModel.fromObject(
                snapshot.data?.docs[i].data(),
              );
              if (advert != null) {
                return AdvertCard(
                  screen: screen,
                  advert: advert,
                  uid: controller.uid,
                  onTapCard: () => controller.goToAdvert(
                    advert,
                  ),
                  onTapLike: () => controller.likeAdvert(
                    advert,
                    isStream: true,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        } else if (snapshot.hasError) {
          return const AppErrorWidget(
            title: StringsKeys.thereAreNoAdverts,
          );
        }
        return const AppProgress();
      },
    );
  }
}
