import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/widgets/app_network_image.dart';

class CreateImageWidget extends StatelessWidget {
  final String image;
  final FileTypeEnums fileType;
  final ResponsiveScreen screen;
  final void Function() remove;

  const CreateImageWidget({
    Key? key,
    required this.image,
    required this.fileType,
    required this.screen,
    required this.remove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: screen.isPhone ? 70 : 100,
          height: screen.isPhone ? 70 : 100,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: fileType == FileTypeEnums.network || kIsWeb ? AppNetworkImage(
            url: image,
          ) : Image.file(
            File(image),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child: InkWell(
            onTap: remove,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: const Center(
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}