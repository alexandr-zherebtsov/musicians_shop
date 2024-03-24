import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/models/brand_model.dart';
import 'package:musicians_shop/data/remote/brands/brands_data_provider.dart';

abstract interface class IBrandsRepository extends BaseRepository {
  Future<List<BrandModel>> getBrands();
  Future<bool> createBrand(final BrandModel brand);
}

final class BrandsRepository implements IBrandsRepository {
  BrandsRepository({
    required final IBrandsDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IBrandsDataProvider _dataProvider;

  @override
  Future<List<BrandModel>> getBrands() => _dataProvider.getBrands();

  @override
  Future<bool> createBrand(final BrandModel brand) =>
      _dataProvider.createBrand(brand);
}
