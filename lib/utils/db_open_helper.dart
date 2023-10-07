import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  static Future<void> initDb({String name = "record.db"}) async {
    sqfliteFfiInit();
    String databasesPath = await getDbDirPath();
    String dbPath = path.join(databasesPath, name);
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(dbPath);
    await db.execute('''
  CREATE TABLE Product (
      id INTEGER PRIMARY KEY,
      title TEXT
  )
  ''');
    await db.insert('Product', <String, Object?>{'title': 'Product 1'});
    await db.insert('Product', <String, Object?>{'title': 'Product 1'});

    var result = await db.query('Product');
    print(result);
    // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
    await db.close();
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
    print('====数据库所在文件夹: $dirPath=======');
    return dirPath;
  }
}
