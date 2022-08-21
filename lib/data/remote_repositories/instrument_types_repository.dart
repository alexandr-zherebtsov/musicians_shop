import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class InstrumentTypesRepository extends BaseRepository {
  Future<List<InstrumentTypeModel>> getInstrumentTypes();

  Future<bool> createInstrumentType(InstrumentTypeModel type);
}
