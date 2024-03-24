import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_data_provider.dart';

abstract interface class IHandleErrorsRepository extends BaseRepository {
  Future<bool> handleError({
    required final Object error,
    required final StackTrace stackTrace,
    required final String name,
  });
}

final class HandleErrorsRepository implements IHandleErrorsRepository {
  HandleErrorsRepository({
    required final IHandleErrorsDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IHandleErrorsDataProvider _dataProvider;

  @override
  Future<bool> handleError({
    required final Object error,
    required final StackTrace stackTrace,
    required final String name,
  }) =>
      _dataProvider.handleError(
        error: error,
        stackTrace: stackTrace,
        name: name,
      );
}
