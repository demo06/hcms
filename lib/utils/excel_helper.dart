import 'dart:io';

import 'package:excel/excel.dart';
import 'package:hcms/model/record.dart';
import 'package:path/path.dart';

class ExcelHelper {
  static const String tableName = "酒店入住信息基本表";

  static Excel createExcel() {
    return Excel.createExcel();
  }

  static Sheet createSheet(Excel excel, String sheetNames) {
    return excel[sheetNames];
  }

  static renameSheet(Excel excel, String oldSheetName, String newSheetName) {
    return excel.rename(oldSheetName, newSheetName);
  }

  static deleteSheet(Excel excel, String sheetName) {
    return excel.delete(sheetName);
  }

  static appendRow<T>(Sheet sheet, List<T> rowData) {
    for (int i = 0; i < rowData.length; i++) {
      if (rowData is List<String>) {
        sheet.insertRowIterables(rowData, i + 1);
      } else if (rowData is List<RoomRecord>) {
        sheet.insertRowIterables((rowData[i] as List<RoomRecord>).toList(), i + 1);
      }
    }
  }

  static setHeader(Sheet sheet, List<String> headers) {
    sheet.insertRowIterables(headers, 0);
  }

  static saveToFile(Excel excel, String filePath, String fileName) {
    //stopwatch.reset();
    List<int>? fileBytes = excel.save();
    //print('saving executed in ${stopwatch.elapsed}');
    if (fileBytes != null) {
      File(join(filePath, '$fileName.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }
  }

  static void generateTable<T>(String tableName, String filePath, List<String> sheetHeader, List<T> data) {
    var excel = createExcel();
    var sheet = createSheet(excel, tableName);
    deleteSheet(excel, "Sheet1");
    setHeader(sheet, sheetHeader);
    appendRow<T>(sheet, data);
    saveToFile(excel, filePath, tableName);
  }
}
