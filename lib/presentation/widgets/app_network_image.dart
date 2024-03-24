import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/widgets/app_progress.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  final bool isPerson;
  final double personSize;
  final bool isProgress;
  final double? width;
  final double? height;

  const AppNetworkImage({
    required this.url,
    this.isPerson = false,
    this.personSize = 30,
    this.isProgress = true,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Get.theme.colorScheme.background,
      child: (url ?? '').isEmpty
          ? AppMediaError(
              isPerson: isPerson,
              personSize: personSize,
            )
          : Image.network(
              url!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.none,
              loadingBuilder: (
                _,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return isProgress ? const AppProgress() : const Offstage();
                }
              },
              errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) {
                return AppMediaError(
                  isPerson: isPerson,
                  personSize: personSize,
                );
              },
            ),
    );
  }
}

class AppMediaError extends StatelessWidget {
  final bool isPerson;
  final double personSize;

  const AppMediaError({
    required this.isPerson,
    required this.personSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isPerson
          ? Icon(
              AppIcons.person,
              size: personSize,
            )
          : Icon(
              AppIcons.error,
            ),
    );
  }
}
