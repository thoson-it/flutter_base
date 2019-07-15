import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  ///Read data from the file path
  Future<String> readFileByPath(String filePath) async {
    try {
      final file = await getLocalFile(filePath);
      return readFile(file);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  ///Read data from the file
  Future<String> readFile(File file) async {
    try {
      if (file.existsSync()) {
        // Read the file.
        return file.readAsStringSync();
      } else {
        // File not exit
        return null;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  ///Write design to the file
  Future<File> writeFileByPath(String filePath, String content) async {
    try {
      final file = await getLocalFile(filePath);
      return file.writeAsString(content);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }

  ///Check is exist folder
  ///Ex: isExitDirectory('dir/subdir')
  Future<bool> isExitDirectory(String folderPath) async {
    final String path = await getLocalPath();
    return Directory('$path/$folderPath').existsSync();
  }

  ///Create folder
  ///Ex: createDesignFolder('dir/subdir')
  Future<Directory> createDirectory(String folderPath) async {
    final String path = await getLocalPath();
    return Directory('$path/$folderPath').create(recursive: true);
  }

  ///Delete file
  ///Ex: deleteFile('folder/filename.type')
  Future<void> deleteFile(String filePath) async {
    final file = await getLocalFile(filePath);
    file.deleteSync();
  }

  ///Get local file
  ///
  Future<File> getLocalFile(String filePath) async {
    final path = await getLocalPath();
    return File('$path/$filePath}');
  }

  ///Get local path
  ///Return:
  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
