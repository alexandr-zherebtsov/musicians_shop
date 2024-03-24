import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_data_provider.dart';

abstract interface class IAdvertsRepository extends BaseRepository {
  Future<List<AdvertModel>> getAdverts();

  Future<bool> createAdvert(final AdvertModel advert);

  Future<bool> editAdvert(final AdvertModel advert);

  Future<bool> deleteAdvert(final String id);

  Future<List<AdvertModel>> getMyAdverts(final String uid);

  Future<List<AdvertModel>> getLikedAdverts(final String uid);
}

final class AdvertsRepository implements IAdvertsRepository {
  AdvertsRepository({
    required final IAdvertsDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IAdvertsDataProvider _dataProvider;

  @override
  Future<List<AdvertModel>> getAdverts() => _dataProvider.getAdverts();

  @override
  Future<bool> createAdvert(final AdvertModel advert) =>
      _dataProvider.createAdvert(advert);

  @override
  Future<bool> editAdvert(final AdvertModel advert) =>
      _dataProvider.editAdvert(advert);

  @override
  Future<bool> deleteAdvert(final String id) => _dataProvider.deleteAdvert(id);

  @override
  Future<List<AdvertModel>> getMyAdverts(final String uid) =>
      _dataProvider.getMyAdverts(uid);

  @override
  Future<List<AdvertModel>> getLikedAdverts(final String uid) =>
      _dataProvider.getLikedAdverts(uid);
}
