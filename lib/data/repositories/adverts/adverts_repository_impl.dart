import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';

class AdvertsRepositoryImpl extends AdvertsRepository {
  final RemoteDataSource _remoteDataSource;
  AdvertsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<AdvertModel>> getAdverts() async {
    return await _remoteDataSource.getAdverts();
  }

  @override
  Future<bool> createAdvert(AdvertModel advert) async {
    return await _remoteDataSource.createAdvert(advert);
  }

  @override
  Future<bool> editAdvert(AdvertModel advert) async {
    return await _remoteDataSource.editAdvert(advert);
  }

  @override
  Future<bool> deleteAdvert(String id) async {
    return await _remoteDataSource.deleteAdvert(id);
  }

  @override
  Future<List<AdvertModel>> getMyAdverts(String uid) async {
    return await _remoteDataSource.getMyAdverts(uid);
  }

  @override
  Future<List<AdvertModel>> getLikedAdverts(String uid) async {
    return await _remoteDataSource.getLikedAdverts(uid);
  }
}
