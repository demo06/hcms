import 'package:hcms/model/record.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RecordDao {
  final Database db;

  RecordDao(this.db);

  Future<int> insert(RoomRecord data) async {
    //插入方法
    String addSql = //插入数据
        "INSERT INTO "
        "Record(roomNo,roomType,payType,currencyUnit,livingDays,price,amountPrice,transType,realPayAmount,date,remark) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
          data.roomNo,
          data.roomType,
          data.payType,
          data.currencyUnit,
          data.livingDays,
          data.price,
          data.amountPrice,
          data.transType,
          data.realPayAmount,
          data.date,
          data.remark
        ]));
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    //插入方法
    return await db.rawQuery("SELECT * "
        "FROM Record");
  }

  //根据 id 查询组件 node
  Future<List<Map<String, dynamic>>> queryById(int date) async {
    return await db.rawQuery(
        "SELECT * "
        "FROM Record "
        "WHERE date = ? ORDER BY id DESc",
        [date]);
  }
}
