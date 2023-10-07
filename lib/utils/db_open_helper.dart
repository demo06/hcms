import 'dart:io';
import 'package:hcms/dao/record_dao.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBHelper {
  //定义了一个静态变量---_dbHelper，保存DBHelper类的单例实例
  static DBHelper? _dbHelper;

  late RecordDao _recordDao;

  RecordDao get recordDao => _recordDao;

  //定义了一个静态方法---getInstance()获取DBHelper的单例实例
  //如果_dbHelper为空，就创建一个新的DBHelper实例
  static DBHelper getInstance() {
    _dbHelper ??= DBHelper();
    return _dbHelper!;
  }

  //_db是一个Database类型的成员，用于存储数据库实例
  Database? _db;

  //数据库中的表
  static const String _record = "Record"; //所有任务

  //database是一个异步getter，它返回数据库实例。如果_db为空，就调用initDB方法初始化数据库。
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    //todo 处理这里闪退的问题
    _recordDao = RecordDao(_db!);
    return _db!;
  }

  //初始化数据库
  initDB({String name = "record.db"}) async {
    //1、初始化数据库
    sqfliteFfiInit();

    //2、获取databaseFactoryFfi对象
    var databaseFactory = databaseFactoryFfi;
    var databasesPath = await getDbDirPath();
    var dbPath = path.join(databasesPath, name);
    //3、创建数据库
    return await databaseFactory.openDatabase(
        //数据库路径
        dbPath,
        //打开数据库操作
        options: OpenDatabaseOptions(
            //版本
            version: 1,
            //创建时操作
            onCreate: (db, version) async {
              print("创建数据库");
              return await db.execute('''
  CREATE TABLE $_record (
      id INTEGER PRIMARY KEY,
      roomNo INTEGER,
      roomType STRING,
      payType STRING,
      currencyUnit STRING,
      livingDays INTEGER,
      price INTEGER,
      amountPrice INTEGER,
      transType STRING,
      realPayAmount INTEGER,
      date INTEGER,            
      remark STRING
  )
  ''');
            }));
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

  Future<void> closeDb() async {
    await _db?.close();
    _db = null;
  }
}
