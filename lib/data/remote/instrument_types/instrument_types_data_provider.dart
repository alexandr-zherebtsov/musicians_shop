import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';
import 'package:musicians_shop/data/models/instrument_type_model.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

abstract interface class IInstrumentTypesDataProvider extends BaseDataProvider {
  Future<List<InstrumentTypeModel>> getInstrumentTypes();

  Future<bool> createInstrumentType(final InstrumentTypeModel type);
}

final class InstrumentTypesDataProvider
    implements IInstrumentTypesDataProvider {
  InstrumentTypesDataProvider({
    required final Logger logger,
    required final FirebaseFirestore firestore,
    required final IHandleErrorsRepository errorHandler,
  })  : _logger = logger,
        _firestore = firestore,
        _errorHandler = errorHandler;

  final Logger _logger;
  final FirebaseFirestore _firestore;
  final IHandleErrorsRepository _errorHandler;

  @override
  Future<List<InstrumentTypeModel>> getInstrumentTypes() async {
    try {
      final QuerySnapshot qs = await _firestore
          .collection(
            AppValues.collectionInstrumentTypes,
          )
          .orderBy('type')
          .get();
      final List<InstrumentTypeModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return InstrumentTypeModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      final InstrumentTypeModel other = res.firstWhere((v) => v.id == '0');
      res.removeWhere((v) => v.id == '0');
      res.add(other);
      return res;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'getInstrumentTypes',
      );
      return <InstrumentTypeModel>[];
    }
  }

  @override
  Future<bool> createInstrumentType(final InstrumentTypeModel type) async {
    try {
      await _firestore
          .collection(
            AppValues.collectionInstrumentTypes,
          )
          .doc(type.id)
          .set(type.toJson());
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'createInstrumentType',
      );
      return false;
    }
  }
}
