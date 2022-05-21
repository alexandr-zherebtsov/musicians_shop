import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/likes_widget.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/price_widget.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_network_image.dart';

class AdvertDesktop extends StatelessWidget {
  final AdvertController controller;

  const AdvertDesktop({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: (controller.advert.images?? []).isEmpty ? const Offstage() : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 4,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppStyles.clipRadius),
                          child: SizedBox(
                            height: 540,
                            child: AnimatedSwitcher(
                              switchOutCurve: Curves.fastLinearToSlowEaseIn,
                              switchInCurve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(milliseconds: 860),
                              transitionBuilder: (widget, animation) => ScaleTransition(
                                scale: animation,
                                child: widget,
                                alignment: Alignment.bottomCenter,
                              ),
                              child: AppNetworkImage(
                                height: 540,
                                width: double.infinity,
                                key: ValueKey<String>(controller.advert.images![controller.selectedImage]),
                                url: controller.advert.images![controller.selectedImage],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.advert.headline?? '',
                              style: Get.textTheme.headline3,
                              softWrap: true,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                              ),
                              child: Text(
                                controller.advert.description?? '',
                                style: Get.textTheme.bodyText1,
                                softWrap: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LikesWidget(
                                    likes: controller.advert.likes?.length ?? 0,
                                    liked: controller.advert.likes?.contains(controller.uid) ?? false,
                                    onTap: controller.onTapLike,
                                  ),
                                  PriceWidget(
                                    price: controller.advert.price,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                (controller.advert.images?? []).isEmpty ? const Offstage() :  SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.advert.images!.length,
                    itemBuilder: (_, int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => controller.selectedImage = i,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppStyles.clipRadius),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 160),
                                width: controller.selectedImage == i ? 110 : 100,
                                height: controller.selectedImage == i ? 110 : 100,
                                child: AppNetworkImage(
                                  url: controller.advert.images![i],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
