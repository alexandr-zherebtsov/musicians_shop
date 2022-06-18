import 'package:musicians_shop/data/repositories/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';

class InstrumentTypesRepositoryImpl extends InstrumentTypesRepository {
  final RemoteDataSource _remoteDataSource;
  InstrumentTypesRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<InstrumentTypeModel>> getInstrumentTypes() async {
    return await _remoteDataSource.getInstrumentTypes();
  }

  @override
  Future<bool> createInstrumentType(InstrumentTypeModel type) async {
    return await _remoteDataSource.createInstrumentType(type);
  }
}
