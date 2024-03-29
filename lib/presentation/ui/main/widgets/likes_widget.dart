import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class LikesWidget extends StatelessWidget {
  final int likes;
  final bool liked;
  final VoidCallback onTap;

  const LikesWidget({
    required this.likes,
    required this.liked,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              liked ? AppIcons.favoriteFilled : AppIcons.favorite,
              color: Get.theme.primaryColor,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 20,
                ),
                child: Text(
                  likes.toString(),
                  style: Get.theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
