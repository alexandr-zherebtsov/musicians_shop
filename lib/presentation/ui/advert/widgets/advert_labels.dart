import 'package:flutter/material.dart';
import 'package:musicians_shop/presentation/widgets/label_widget.dart';

class AdvertLabels extends StatelessWidget {
  final String? brand;
  final String? type;
  final EdgeInsets padding;

  const AdvertLabels({
    required this.brand,
    required this.type,
    this.padding = const EdgeInsets.only(
      left: 12,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: brand == null && type == null,
      child: Padding(
        padding: padding,
        child: Wrap(
          children: [
            Padding(
              padding: brand == null
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(
                      top: 8,
                      right: 12,
                    ),
              child: LabelWidget(
                label: brand,
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 6,
                ),
              ),
            ),
            Padding(
              padding: type == null
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(
                      top: 8,
                      right: 12,
                    ),
              child: LabelWidget(
                label: type,
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
