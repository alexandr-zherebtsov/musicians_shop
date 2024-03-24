import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/models/instrument_type_model.dart';
import 'package:musicians_shop/data/remote/instrument_types/instrument_types_data_provider.dart';

abstract interface class IInstrumentTypesRepository extends BaseRepository {
  Future<List<InstrumentTypeModel>> getInstrumentTypes();

  Future<bool> createInstrumentType(final InstrumentTypeModel type);
}

final class InstrumentTypesRepository implements IInstrumentTypesRepository {
  InstrumentTypesRepository({
    required final IInstrumentTypesDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IInstrumentTypesDataProvider _dataProvider;

  @override
  Future<List<InstrumentTypeModel>> getInstrumentTypes() =>
      _dataProvider.getInstrumentTypes();

  @override
  Future<bool> createInstrumentType(final InstrumentTypeModel type) =>
      _dataProvider.createInstrumentType(type);
}
