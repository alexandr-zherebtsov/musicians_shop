import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/data/sources/remote_data_source_impl.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Logger>(
      () => Logger(
        printer: PrettyPrinter(
          printEmojis: false,
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<RemoteDataSource>(
      () => RemoteDataSourceImpl(
        Get.find<Logger>(),
        FirebaseAuth.instance,
        FirebaseStorage.instance,
        FirebaseFirestore.instance,
        FirebaseMessaging.instance,
        FirebaseAnalytics.instance,
        FirebaseCrashlytics.instance,
      ),
      fenix: true,
    );
  }
}
