import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:musicians_shop/data/remote/file_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class FileRepositoryImpl extends FileRepository {
  final FirebaseStorage _fs;
  final HandleErrorsRepository _he;

  FileRepositoryImpl(
    this._fs,
    this._he,
  );

  @override
  Future<String?> uploadFile({
    required PlatformFile file,
    required FileTypeEnums type,
  }) async {
    try {
      if (kIsWeb) {
        String? imgUrl;
        final Reference ref = _fs.ref().child(getFileUrl(type) + getFileFormatFromString(
          file.name,
          dot: true,
        ));
        await ref.putData(
          file.bytes!,
          SettableMetadata(
            contentType: getFileType(
              fileName: file.name,
              type: type,
            ),
          ),
        ).whenComplete(() async {
          await ref.getDownloadURL().then((String v) {
            imgUrl = v;
          });
        });
        return imgUrl;
      } else {
        final UploadTask ut = _fs.ref().child(
          getFileUrl(type) + getFileFormatFromFile(
            path: file.path!,
            name: file.name,
            dot: true,
          ),
        ).putFile(File(file.path!));
        final String imgUrl = await(await ut).ref.getDownloadURL();
        return imgUrl;
      }
    } catch (e, s) {
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'uploadFile',
      );
      return null;
    }
  }

  @override
  Future<bool> deleteFile(String fileUrl) async {
    try {
      await _fs.refFromURL(fileUrl).delete();
      return true;
    } catch (e, s) {
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'deleteFile',
      );
      return false;
    }
  }
}
