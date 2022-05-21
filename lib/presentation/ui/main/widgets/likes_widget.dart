import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikesWidget extends StatelessWidget {
  final int likes;
  final bool liked;
  final void Function() onTap;

  const LikesWidget({
    Key? key,
    required this.likes,
    required this.liked,
    required this.onTap,
  }) : super(key: key);

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
              liked ? Icons.favorite : Icons.favorite_outline,
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
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
