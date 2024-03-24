import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';
import 'package:musicians_shop/data/models/brand_model.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

abstract interface class IBrandsDataProvider extends BaseDataProvider {
  Future<List<BrandModel>> getBrands();

  Future<bool> createBrand(final BrandModel brand);
}

final class BrandsDataProvider implements IBrandsDataProvider {
  BrandsDataProvider({
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
  Future<List<BrandModel>> getBrands() async {
    try {
      final QuerySnapshot qs = await _firestore
          .collection(
            AppValues.collectionBrands,
          )
          .orderBy('name')
          .get();
      final List<BrandModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return BrandModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      final BrandModel other = res.firstWhere((v) => v.id == '0');
      res.removeWhere((v) => v.id == '0');
      res.add(other);
      return res;
    } catch (e, s) {
      await _errorHandler.handleError(
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
      await _firestore
          .collection(
            AppValues.collectionBrands,
          )
          .doc(brand.id)
          .set(brand.toJson());
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'createBrand',
      );
      return false;
    }
  }
}
