import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class AdvertsRepository extends BaseRepository {
  Future<List<AdvertModel>> getAdverts();

  Future<bool> editAdvert(AdvertModel advert);

  Future<List<AdvertModel>> getMyAdverts(String uid);

  Future<List<AdvertModel>> getLikedAdverts(String uid);
}

