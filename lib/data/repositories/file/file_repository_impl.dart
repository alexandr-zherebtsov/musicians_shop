import 'package:image_picker/image_picker.dart';
import 'package:musicians_shop/data/repositories/file/file_repository.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';

class FileRepositoryImpl extends FileRepository {
  final RemoteDataSource _remoteDataSource;
  FileRepositoryImpl(this._remoteDataSource);

  @override
  Future<String?> uploadFile({
    required XFile file,
    required FileTypeEnums type,
  }) async {
    return await _remoteDataSource.uploadFile(
      file: file,
      type: type,
    );
  }

  @override
  Future<bool> deleteFile(String fileUrl) async {
    return await _remoteDataSource.deleteFile(fileUrl);
  }
}
