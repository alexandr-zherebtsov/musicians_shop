import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class HandleErrorsRepository extends BaseRepository {
  Future<bool> handleError({
    required Object error,
    required StackTrace stackTrace,
    required String name,
  });
}
