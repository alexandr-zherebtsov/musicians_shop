import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class PushNotificationRepository extends BaseRepository {
  Future<bool> initializePN();
}
