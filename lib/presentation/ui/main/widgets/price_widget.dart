import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class PriceWidget extends StatelessWidget {
  final double? price;

  const PriceWidget({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: price == null,
      child: Container(
        height: 25,
        padding: const EdgeInsets.only(
          left: 8,
          right: 6,
        ),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(AppStyles.clipRadius),
        ),
        child: Center(
          child: Text(
            '${priceParser(price.toString())} \$',
            style: Get.theme.textTheme.bodyText2?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
