import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoItem extends StatelessWidget {
  final String title;
  final String? data;

  const UserInfoItem({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: (data ?? '').isEmpty,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 22,
          right: 8,
          bottom: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Get.theme.textTheme.bodyText2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 6
              ),
              child: Text(
                data ?? '',
                style: Get.theme.textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
