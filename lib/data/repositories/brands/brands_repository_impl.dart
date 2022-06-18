import 'package:musicians_shop/data/repositories/brands/brands_repository.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';

class BrandsRepositoryImpl extends BrandsRepository {
  final RemoteDataSource _remoteDataSource;
  BrandsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<BrandModel>> getBrands() async {
    return await _remoteDataSource.getBrands();
  }

  @override
  Future<bool> createBrand(BrandModel brand) async {
    return await _remoteDataSource.createBrand(brand);
  }
}
