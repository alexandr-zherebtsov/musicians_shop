import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

enum FileTypeEnums {
  userPhoto,
  advertPhoto,
  network,
  file,
}

class FileToUpload {
  final PlatformFile? platformFile;
  final XFile? xFile;
  final FileTypeEnums type;

  FileToUpload({
    this.platformFile,
    this.xFile,
    required this.type,
  });
}
