import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';
import 'package:musicians_shop/data/models/file_to_upload.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

abstract interface class IFileDataProvider extends BaseDataProvider {
  Future<String?> uploadFile(final FileToUpload file);

  Future<bool> deleteFile(final String fileUrl);
}

final class FileDataProvider implements IFileDataProvider {
  FileDataProvider({
    required final FirebaseStorage storage,
    required final IHandleErrorsRepository errorHandler,
  })  : _storage = storage,
        _errorHandler = errorHandler;

  final FirebaseStorage _storage;
  final IHandleErrorsRepository _errorHandler;

  @override
  Future<String?> uploadFile(final FileToUpload file) async {
    try {
      if (file.platformFile != null) {
        return await _platformFileUpload(file);
      } else if (file.xFile != null) {
        return _pickerFileUpload(file);
      }
      return null;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'uploadFile',
      );
      return null;
    }
  }

  Future<String?> _platformFileUpload(final FileToUpload file) async {
    try {
      if (kIsWeb) {
        String? imgUrl;
        final Reference ref = _storage.ref().child(
              MainUtils.getFileUrl(file.type) +
                  MainUtils.getFileFormatFromString(
                    file.platformFile!.name,
                    dot: true,
                  ),
            );
        await ref
            .putData(
          file.platformFile!.bytes!,
          SettableMetadata(
            contentType: MainUtils.getFileType(
              fileName: file.platformFile!.name,
              type: file.type,
            ),
          ),
        )
            .whenComplete(
          () async {
            await ref.getDownloadURL().then(
              (String v) {
                imgUrl = v;
              },
            );
          },
        );
        return imgUrl;
      } else {
        final UploadTask ut = _storage
            .ref()
            .child(
              MainUtils.getFileUrl(file.type) +
                  MainUtils.getFileFormatFromFile(
                    path: file.platformFile!.path!,
                    name: file.platformFile!.name,
                    dot: true,
                  ),
            )
            .putFile(
              File(
                file.platformFile!.path!,
              ),
            );
        final String imgUrl = await (await ut).ref.getDownloadURL();
        return imgUrl;
      }
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'platformFileUpload',
      );
      return null;
    }
  }

  Future<String?> _pickerFileUpload(final FileToUpload file) async {
    try {
      if (kIsWeb) {
        String? imgUrl;
        final Reference ref = _storage.ref().child(
              MainUtils.getFileUrl(file.type) +
                  MainUtils.getFileFormatFromString(
                    file.xFile!.name,
                    dot: true,
                  ),
            );
        await ref
            .putData(
          await file.xFile!.readAsBytes(),
          SettableMetadata(
            contentType: MainUtils.getFileType(
              fileName: file.xFile!.name,
              type: file.type,
            ),
          ),
        )
            .whenComplete(
          () async {
            await ref.getDownloadURL().then(
              (String v) {
                imgUrl = v;
              },
            );
          },
        );
        return imgUrl;
      } else {
        final UploadTask ut = _storage
            .ref()
            .child(
              MainUtils.getFileUrl(file.type) +
                  MainUtils.getFileFormatFromFile(
                    path: file.xFile!.path,
                    name: file.xFile!.name,
                    dot: true,
                  ),
            )
            .putFile(
              File(
                file.xFile!.path,
              ),
            );
        final String imgUrl = await (await ut).ref.getDownloadURL();
        return imgUrl;
      }
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'pickerFileUpload',
      );
      return null;
    }
  }

  @override
  Future<bool> deleteFile(final String fileUrl) async {
    try {
      await _storage.refFromURL(fileUrl).delete();
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'deleteFile',
      );
      return false;
    }
  }
}
