import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class PushNotificationRepository extends BaseRepository {
  Future<bool> initializePN();

  Future<void> setFcmToken({
    required final String? newToken,
    required final String? oldToken,
  });

  Future<void> removeFcmToken(final String? token);
}
