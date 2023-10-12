import 'dart:io';
import 'package:hcms/model/record.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class ExcelHelper {
  static const String tableName = "酒店入住信息基本表";

  static Excel createExcel() {
    return Excel.createExcel();
  }

  static Sheet createSheet(Excel excel, String sheetNames) {
    return excel[sheetNames];
  }

  static appendRow(Sheet sheet, List<List<RoomRecord>> rowData) {
    for (var row in rowData) {
      sheet.appendRow(row);
    }
  }

  static setHeader(Sheet sheet, List<String> headers) {
    sheet.insertRowIterables(headers, 0);
  }

  static saveToFile(Excel excel, String filePath) {
    //stopwatch.reset();
    List<int>? fileBytes = excel.save();
    //print('saving executed in ${stopwatch.elapsed}');
    if (fileBytes != null) {
      File(join(filePath))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }
  }

  static void generateTable(String filePath, List<String> sheetHeader, List<RoomRecord> data) {
    List<List<RoomRecord>> rowData = List.generate(data.length + 1, (index) => data);
    var excel = createExcel();
    var sheet = createSheet(excel, tableName);
    setHeader(sheet, sheetHeader);
    appendRow(sheet, rowData);
    saveToFile(excel, filePath);
  }
}
