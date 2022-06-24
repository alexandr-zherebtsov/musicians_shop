import 'package:musicians_shop/data/repositories/push_notification/push_notification_repository.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';

class PushNotificationRepositoryImpl extends PushNotificationRepository {
  final RemoteDataSource _remoteDataSource;
  PushNotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> initializePN() async {
    return await _remoteDataSource.initializePN();
  }
}
