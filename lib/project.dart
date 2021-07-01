import 'dart:io';
import 'package:path/path.dart';

class Project {
  String _getRootDirectoryPath() => Directory.current.path;

  File? getPubspecFile() {
    var rootDirPath = _getRootDirectoryPath();
    var pubspecFilePath = join(rootDirPath, 'pubspec.yaml');
    var pubspecFile = File(pubspecFilePath);

    return pubspecFile.existsSync() ? pubspecFile : null;
  }

  Future<File> createDartFileForIcons(String path, String name) async {
    final rootDirectory = _getRootDirectoryPath();
    final filePath = join(rootDirectory, path, '${name}_icons.dart');
    final file = File(filePath);
    await file.create(recursive: true);
    return file;
  }

  Future<File> createFontFile(String path) async {
    final rootDirectory = _getRootDirectoryPath();
    final filePath = join(rootDirectory, path);
    final file = File(filePath);
    await file.create(recursive: true);
    return file;
  }
}
