import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: kIsWeb ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
      ) : Platform.isIOS || Platform.isMacOS ? const CupertinoActivityIndicator() : CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
      ),
    );
  }
}
