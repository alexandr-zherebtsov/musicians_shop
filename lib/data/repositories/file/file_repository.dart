import 'package:file_picker/file_picker.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';

abstract class FileRepository extends BaseRepository {
  Future<String?> uploadFile({
    required PlatformFile file,
    required FileTypeEnums type,
  });

  Future<bool> deleteFile(String fileUrl);
}
