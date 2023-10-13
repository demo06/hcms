import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static String getFileName(String path) {
    return path.substring(path.lastIndexOf('/') + 1);
  }

  static String getFileExtension(String path) {
    return path.substring(path.lastIndexOf('.') + 1);
  }

  static String getFileNameWithoutExtension(String path) {
    return path.substring(0, path.lastIndexOf('.'));
  }

  static Future<String> getDbDirPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dirName = 'databases';
    String dirPath = path.join(appDocDir.path, dirName);
    dirPath = path.join(appDocDir.path, 'hcms', 'databases');
    Directory result = Directory(dirPath);
    if (!result.existsSync()) {
      result.createSync(recursive: true);
    }
    // print('====数据库所在文件夹: $dirPath=======');
    return dirPath;
  }

  static Future<String> getDesktopPath() async {
    String dirPath = (await getApplicationDocumentsDirectory()).parent.path;
    return path.join(dirPath, 'Desktop');
  }
}
