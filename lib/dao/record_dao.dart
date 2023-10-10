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
  Future<List<Map<String, dynamic>>> count() async {
    return await db.rawQuery("SELECT COUNT(*) FROM Record;");
  }
  Future<List<Map<String, dynamic>>> queryAll() async {
    return await db.rawQuery("SELECT * "
        "FROM Record ORDER BY id DESC");
  }

  //根据 id 查询组件 node
  Future<List<Map<String, dynamic>>> queryById(int date) async {
    return await db.rawQuery(
        "SELECT * "
        "FROM Record "
        "WHERE date = ? ORDER BY id DESc",
        [date]);
  }

  Future<int> update(RoomRecord record) async {
    //插入方法
    String updateSql = //插入数据
        "UPDATE Record SET roomNo=? , roomType=? ,payType=?, currencyUnit=?,livingDays=?,price=?,amountPrice=?,transType=?,realPayAmount=?,remark=? "
        "WHERE id = ?";

    return await db.rawUpdate(updateSql, [
      record.roomNo,
      record.roomType,
      record.payType,
      record.currencyUnit,
      record.livingDays,
      record.price,
      record.amountPrice,
      record.transType,
      record.realPayAmount,
      record.remark,
      record.id
    ]);
  }

  Future<int> delete(int id) async {
    String deleteSql = "DELETE FROM Record WHERE id = ?";
    return await db.rawDelete(deleteSql, [id]);
  }
}
