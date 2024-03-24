import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/remote/push_notification/push_notification_data_provider.dart';

abstract interface class IPushNotificationRepository extends BaseRepository {
  Future<bool> initializePN();

  Future<void> setFcmToken({
    required final String? newToken,
    required final String? oldToken,
  });

  Future<void> removeFcmToken();

  Future<String?> getFcmToken();

  Future<void> deleteFcmToken();
}

final class PushNotificationRepository implements IPushNotificationRepository {
  PushNotificationRepository({
    required final IPushNotificationDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IPushNotificationDataProvider _dataProvider;

  @override
  Future<bool> initializePN() => _dataProvider.initializePN();

  @override
  Future<void> setFcmToken({
    required final String? newToken,
    required final String? oldToken,
  }) =>
      _dataProvider.setFcmToken(
        newToken: newToken,
        oldToken: oldToken,
      );

  @override
  Future<void> removeFcmToken() => _dataProvider.removeFcmToken();

  @override
  Future<String?> getFcmToken() => _dataProvider.getFcmToken();

  @override
  Future<void> deleteFcmToken() => _dataProvider.deleteFcmToken();
}
