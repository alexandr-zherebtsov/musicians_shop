import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';
import 'package:musicians_shop/presentation/ui/advert/widgets/advert_labels.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/likes_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_network_image.dart';
import 'package:musicians_shop/presentation/widgets/label_widget.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class AdvertMobile extends StatelessWidget {
  final AdvertController controller;

  const AdvertMobile({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (controller.advert.images ?? []).isEmpty
                  ? const Offstage()
                  : CarouselSlider(
                      items: controller.advert.images!.map((e) {
                        return SizedBox(
                          width: Get.width,
                          child: AppNetworkImage(
                            url: e,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  controller.advert.headline ?? '',
                  style: Get.textTheme.headlineMedium,
                  softWrap: true,
                ),
              ),
              AdvertLabels(
                brand: controller.advert.brand?.name,
                type: controller.advert.type?.type?.tr,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 16,
                  right: 16,
                  bottom: 12,
                ),
                child: Text(
                  controller.advert.description ?? '',
                  style: Get.textTheme.bodyLarge,
                  softWrap: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LikesWidget(
                      likes: controller.advert.likes?.length ?? 0,
                      liked:
                          controller.advert.likes?.contains(controller.uid) ??
                              false,
                      onTap: controller.onTapLike,
                    ),
                    LabelWidget(
                      label: '${MainUtils.priceParser(
                        controller.advert.price.toString(),
                      )} \$',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
