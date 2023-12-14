import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Directory? _tempDir;
  static Directory? _appDocumentsDir;
  static Directory? _downloadsDir;

  static Future<Directory?> get tempDir async {
    _tempDir ??= await getTemporaryDirectory();
    return _tempDir;
  }

  static Future<Directory?> get appDocumentsDir async {
    _appDocumentsDir ??= await getApplicationDocumentsDirectory();
    return _appDocumentsDir;
  }

  static Future<Directory?> get downloadsDir async {
    _downloadsDir ??= await getDownloadsDirectory();
    return _downloadsDir;
  }

  static Future<File> moveFile(ByteData sourceFile, String newPath) async {
    // await delDir(newPath);
    // await ensureDirExists(newPath.replaceFirst(from, to) path.basename(newPath));
    final newFile = File(newPath);
    try {
      // prefer using rename as it is probably faster
      // final newFile = File(newPath);
      await newFile.writeAsBytes(sourceFile.buffer.asUint8List());
      // return await sourceFile.rename(newPath);
    } on FileSystemException catch (e) {
      // if rename fails, copy the source file and then delete it
      // final newFile = File(newPath);
      // await newFile.writeAsBytes(await sourceFile.readAsBytes());
      // final newFile = await sourceFile.copy(newPath);
      // await sourceFile.delete();
      // return newFile;
    } finally {
      return newFile;
    }
  }

  static Future<void> ensureDirExists(String path) async {
    final dir = Directory(path);
    final exists = await dir.exists();
    if (!exists) {
      await dir.create(recursive: true);
    }
  }

  static Future<void> delDir(String path) async {
    final dir = Directory(path);
    final exists = await dir.exists();
    if (exists) {
      await dir.delete(recursive: true);
    }
  }
}