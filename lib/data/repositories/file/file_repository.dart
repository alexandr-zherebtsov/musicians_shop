import 'package:image_picker/image_picker.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';

abstract class FileRepository extends BaseRepository {
  Future<String?> uploadFile({
    required XFile file,
    required FileTypeEnums type,
  });

  Future<bool> deleteFile(String fileUrl);
}
