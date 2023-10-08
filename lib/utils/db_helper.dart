import 'dart:async';
import 'dart:io';
import 'package:hcms/dao/record_dao.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DB {
  Database? _db;

  DB._();

  static DB instance = DB._();

  late RecordDao _recordDao;

  RecordDao get recordDao => _recordDao;

  Database get db => _db!;

  bool get inited => _db != null;

  //数据库中的表
  static const String _record = "Record"; //所有任务

  Future<void> initDb({String name = "record.db"}) async {
    if (_db != null) return;
    sqfliteFfiInit();
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    var databasesPath = await getDbDirPath();
    var dbPath = path.join(databasesPath, name);
    _db = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
        // onUpgrade: _onUpgrade,
        // onOpen: _onOpen
      ),
    );
    _recordDao = RecordDao(_db!);
    // print('初始化数据库....');
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

  Future<void> closeDb() async {
    await _db?.close();
    _db = null;
  }

  FutureOr<void> _onCreate(Database db, int version) {
    return db.execute('''
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
  }
}
