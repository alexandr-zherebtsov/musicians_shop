import 'package:get/get.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/data/sources/remote_data_source_impl.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl(), fenix: true);
  }
}
