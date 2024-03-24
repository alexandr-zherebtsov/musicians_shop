import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/likes_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_network_image.dart';
import 'package:musicians_shop/presentation/widgets/label_widget.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class AdvertCard extends StatelessWidget {
  final ResponsiveScreen screen;
  final AdvertModel advert;
  final String uid;
  final VoidCallback onTapCard;
  final VoidCallback onTapLike;

  const AdvertCard({
    required this.screen,
    required this.advert,
    required this.uid,
    required this.onTapCard,
    required this.onTapLike,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: screen.isPhone
          ? const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            )
          : const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 28,
            ),
      child: InkWell(
        onTap: onTapCard,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppStyles.clipRadius),
                      child: SizedBox(
                        height: 140,
                        width: 140,
                        child: AppNetworkImage(
                          url: advert.images?[0] ?? '',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            advert.headline ?? '',
                            style: Get.theme.textTheme.titleLarge,
                            softWrap: false,
                            overflow: kIsWeb
                                ? TextOverflow.ellipsis
                                : TextOverflow.fade,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                advert.description ?? '',
                                style: Get.theme.textTheme.bodyLarge,
                                softWrap: true,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LikesWidget(
                      likes: advert.likes?.length ?? 0,
                      liked: advert.likes?.contains(uid) ?? false,
                      onTap: onTapLike,
                    ),
                    LabelWidget(
                      label: '${MainUtils.priceParser(
                        advert.price.toString(),
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
