import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/models/file_to_upload.dart';
import 'package:musicians_shop/data/remote/file/file_data_provider.dart';

abstract interface class IFileRepository extends BaseRepository {
  Future<String?> uploadFile(final FileToUpload file);

  Future<bool> deleteFile(final String fileUrl);
}

final class FileRepository implements IFileRepository {
  FileRepository({
    required final IFileDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IFileDataProvider _dataProvider;

  @override
  Future<String?> uploadFile(final FileToUpload file) =>
      _dataProvider.uploadFile(file);

  @override
  Future<bool> deleteFile(final String fileUrl) =>
      _dataProvider.deleteFile(fileUrl);
}
