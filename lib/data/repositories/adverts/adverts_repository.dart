import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class AdvertsRepository extends BaseRepository {
  Future<List<AdvertModel>> getAdverts();

  Future<bool> createAdvert(AdvertModel advert);

  Future<bool> editAdvert(AdvertModel advert);

  Future<bool> deleteAdvert(String id);

  Future<List<AdvertModel>> getMyAdverts(String uid);

  Future<List<AdvertModel>> getLikedAdverts(String uid);
}

