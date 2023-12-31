import 'package:hcms/global/constants.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/utils/time_util.dart';
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

  Future<List<Map<String, Object?>>> count() async {
    return await db.rawQuery("SELECT COUNT(*) FROM Record;");
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    return await db.rawQuery("SELECT * "
        "FROM Record ORDER BY id DESC");
  }

  Future<List<Map<String, dynamic>>> getTwentyItems(int pageNumber) async {
    int offset = (pageNumber - 1) * Constants.pageSize;
    List<Map<String, dynamic>> result =
        await db.query('record', limit: Constants.pageSize, offset: offset, orderBy: 'id DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getSummary(
    String? roomType,
    String currencyUnit,
    String transType,
    int startTime,
    int endTime,
  ) async {
    final String sql = roomType != null
        ? "SELECT SUM(realPayAmount) FROM Record WHERE roomType = ? AND currencyUnit=? AND transType=? AND date>=? AND date<= ?"
        : "SELECT SUM(realPayAmount) FROM Record WHERE currencyUnit=? AND transType=? AND date>=? AND date<= ?";

    final List<dynamic> params = roomType != null
        ? [roomType, currencyUnit, transType, startTime, endTime]
        : [currencyUnit, transType, startTime, endTime];
    final result = await db.rawQuery(sql, params);
    return result;
  }

  Future<List<Map<String, dynamic>>> getTimeZoneBase(startTime, endTime) async {
    // List<Map<String, dynamic>> result =
    //     await db.query('record', where: 'date >= ? and date < ?', whereArgs: [startTime, endTime], orderBy: 'id DESC');
    String sql ="SELECT id,date,roomNo,roomType,livingDays,currencyUnit,price,realPayAmount,transType,remark FROM Record WHERE date >= ? and date < ? ORDER BY id DESC";
    List<Map<String, dynamic>> result =
        await db.rawQuery(sql,[startTime, endTime]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getTypeRate(String roomType) async {
    List<Map<String, dynamic>> result = await db.query('record',
        where: 'date >= ? and date < ? and roomType=?',
        whereArgs: [TimeUtil.getMonthStart(), TimeUtil.getMonthEnd(), roomType],
        orderBy: 'id DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTimeZoneSummary(startTime, endTime) async {
    List<Map<String, dynamic>> result =
        await db.query('record', where: 'date >= ? and date < ?', whereArgs: [startTime, endTime], orderBy: 'id DESC');
    return result;
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
        "UPDATE Record SET roomNo=? , roomType=? ,payType=?, currencyUnit=?,livingDays=?,price=?,amountPrice=?,transType=?,realPayAmount=?,date=?,remark=? "
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
      record.date,
      record.remark,
      record.id
    ]);
  }

  Future<int> delete(int id) async {
    String deleteSql = "DELETE FROM Record WHERE id = ?";
    return await db.rawDelete(deleteSql, [id]);
  }
}
