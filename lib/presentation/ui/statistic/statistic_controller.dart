import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/remote/adverts_repository.dart';
import 'package:musicians_shop/data/remote/user_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';

class StatisticController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final AdvertsRepository _advertsRepository = Get.find<AdvertsRepository>();

  UserModel? user;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  List<AdvertModel> statisticAdverts = <AdvertModel>[];
  List<AdvertModel> myAdverts = <AdvertModel>[];

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  bool _screenError = false;
  bool get screenError => _screenError;
  set screenError(bool screenError) {
    _screenError = screenError;
    update();
  }


  bool noLikes = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    screenLoader = true;
    await Future.wait([
      getUser(),
      getAdverts(),
      getMyAdverts(),
    ]);
    sortAdverts();
    checkLikes();
    screenLoader = false;
  }

  Future<void> getUser() async {
    user = await _userRepository.getUser(uid);
    if (user == null) {
      screenError = true;
    }
  }

  Future<void> getAdverts() async {
    statisticAdverts = await _advertsRepository.getAdverts();
  }

  Future<void> getMyAdverts() async {
    myAdverts = await _advertsRepository.getMyAdverts(uid);
  }

  void checkLikes() {
    if (myAdverts.isNotEmpty) {
      int i = 0;
      for (AdvertModel e in myAdverts) {
        i = i + (e.likes ?? []).length;
      }
      noLikes = i < 1;
    }
  }

  void sortAdverts() {
    for (int v = 0; v < statisticAdverts.length; v++) {
      double count = 0;
      if ((user?.favoriteInstruments?? []).isNotEmpty && statisticAdverts[v].type?.id != null) {
        for (int i = 0; i < user!.favoriteInstruments!.length; i++) {
          if (user!.favoriteInstruments![i].id == statisticAdverts[v].type!.id!) {
            count += 10;
          }
        }
      }
      if ((user?.favoriteBrands?? []).isNotEmpty && statisticAdverts[v].brand?.id != null) {
        for (int i = 0; i < user!.favoriteBrands!.length; i++) {
          if (user!.favoriteBrands![i].id == statisticAdverts[v].brand!.id!) {
            count += 10;
          }
        }
      }
      if (user?.city == statisticAdverts[v].city && (user?.city?? '').isNotEmpty) {
        count += 5;
      }
      if ((statisticAdverts[v].likes?? []).isNotEmpty) {
        count += statisticAdverts[v].likes!.length * 0.01;
      }
      if ((statisticAdverts[v].images?? []).isNotEmpty) {
        count += statisticAdverts[v].images!.length * 0.01;
      }
      if ((statisticAdverts[v].description?? '').isNotEmpty) {
        if (statisticAdverts[v].description!.length >= 1000) {
          count += 1.5;
        } else {
          count += 0.5;
        }
      }
      statisticAdverts[v].userCount = count;
    }
  }

  void goToAdvert(int? index) async {
    if (index != null) {
      final res = await Get.toNamed(
        AppRoutes.advert,
        arguments: myAdverts[index],
      );
      if (res == true) {
        onInit();
      }
    }
  }
}
