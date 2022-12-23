import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class BrandsRepository extends BaseRepository {
  Future<List<BrandModel>> getBrands();
  Future<bool> createBrand(BrandModel brand);
}
