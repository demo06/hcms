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

  static appendRow(Sheet sheet, List<RoomRecord> rowData) {
    for (int i = 0; i < rowData.length; i++) {
      sheet.insertRowIterables(rowData[i].toList(), i + 1);
    }
  }

  static appendRows(Sheet sheet, List<List<String>> rowData) {
    for (int i = 0; i < rowData.length; i++) {
      sheet.insertRowIterables(rowData[i], i + 1);
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

  static void generateTable(String tableName, String filePath, List<String> sheetHeader, List data) {
    var excel = createExcel();
    var sheet = createSheet(excel, tableName);
    deleteSheet(excel, "Sheet1");
    setHeader(sheet, sheetHeader);
    if (data is List<List<String>>) {
      appendRows(sheet, data.cast<List<String>>());
    } else {
      appendRow(sheet, data.cast<RoomRecord>());
    }
    saveToFile(excel, filePath, tableName);
  }
}
