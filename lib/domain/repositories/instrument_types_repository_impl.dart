import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote_repositories/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote_repositories/instrument_types_repository.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';

class InstrumentTypesRepositoryImpl extends InstrumentTypesRepository {
  final Logger _logger;
  final FirebaseFirestore _db;
  final HandleErrorsRepository _he;

  InstrumentTypesRepositoryImpl(
    this._logger,
    this._db,
    this._he,
  );

  @override
  Future<List<InstrumentTypeModel>> getInstrumentTypes() async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionInstrumentTypes,
      ).orderBy('type').get();
      final List<InstrumentTypeModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return InstrumentTypeModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      final InstrumentTypeModel other = res.firstWhere((v) => v.id == '0');
      res.removeWhere((v) => v.id == '0');
      res.add(other);
      return res;
    } catch (e, s) {
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'getInstrumentTypes',
      );
      return <InstrumentTypeModel>[];
    }
  }

  @override
  Future<bool> createInstrumentType(InstrumentTypeModel type) async {
    try {
      await _db.collection(
        AppValues.collectionInstrumentTypes,
      ).doc(type.id).set(type.toJson());
      return true;
    } catch (e, s) {
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'createInstrumentType',
      );
      return false;
    }
  }
}
