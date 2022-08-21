import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote_repositories/brands_repository.dart';
import 'package:musicians_shop/data/remote_repositories/handle_errors_repository.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';

class BrandsRepositoryImpl extends BrandsRepository {
  final Logger _logger;
  final FirebaseFirestore _db;
  final HandleErrorsRepository _he;

  BrandsRepositoryImpl(
    this._logger,
    this._db,
    this._he,
  );

  @override
  Future<List<BrandModel>> getBrands() async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionBrands,
      ).orderBy('name').get();
      final List<BrandModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return BrandModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      final BrandModel other = res.firstWhere((v) => v.id == '0');
      res.removeWhere((v) => v.id == '0');
      res.add(other);
      return res;
    } catch (e, s) {
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'getBrands',
      );
      return <BrandModel>[];
    }
  }

  @override
  Future<bool> createBrand(BrandModel brand) async {
    try {
      await _db.collection(
        AppValues.collectionBrands,
      ).doc(brand.id).set(brand.toJson());
      return true;
    } catch (e, s) {
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'createBrand',
      );
      return false;
    }
  }
}
