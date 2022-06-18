import 'package:flutter/material.dart';
import 'package:musicians_shop/shared/widgets/label_widget.dart';

class AdvertLabels extends StatelessWidget {
  final String? brand;
  final String? type;

  const AdvertLabels({
    Key? key,
    required this.brand,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: brand == null && type == null,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
        ),
        child: Row(
          children: [
            Padding(
              padding: brand == null ? EdgeInsets.zero : const EdgeInsets.only(
                top: 8,
                right: 12,
              ),
              child: LabelWidget(
                label: brand,
              ),
            ),
            Padding(
              padding: type == null ? EdgeInsets.zero : const EdgeInsets.only(
                top: 8,
                right: 12,
              ),
              child: LabelWidget(
                label: type,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
