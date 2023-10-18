import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcms/global/constants.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/utils/excel_helper.dart';
import 'package:hcms/utils/file_util.dart';
import 'package:hcms/utils/time_util.dart';
import 'package:sqflite/sqflite.dart';

import 'record_state.dart';

class RecordLogic extends GetxController {
  final RecordState state = RecordState();

  @override
  Future<void> onInit() async {
    refreshList();
    super.onInit();
  }

  void initData(RoomRecord record) async {
    state.record = record;
    state.priceController.text = record.price.toString();
    state.realIncomeController.text = record.realPayAmount.toString();
    state.remarkController.text = record.remark.toString();
  }

  Future<int> exportMonthResideRate(int type) async {
    //todo这里要调整
    var deskTopPath = await FileUtils.getDesktopPath();
    Map<String, int> resideMap = {};
    List<String> header = ["日期", "入住房间数", "入住率", "备注"];
    List<List<String>> body = [];
    var recordList = await state.recordDao.getTypeRate(type == 1 ? "宾馆" : "公寓");
    var datas = recordList.map((e) => RoomRecord.fromJson(e)).toList();
    for (var record in datas) {
      var date = TimeUtil.transMillToDate(millisconds: record.date.toInt());
      if (resideMap.containsKey(date)) {
        resideMap.update(date, (value) => value += 1);
      } else {
        resideMap[date] = 1;
      }
    }
    resideMap.forEach((key, value) {
      body.add([key, value.toString(), "${(value / 28 * 100).toStringAsFixed(2)}%", ""]);
    });
    try {
      ExcelHelper.generateTable(type == 1 ? "宾馆当月入住率${TimeUtil.getTodayDate()}" : "公寓当月入住率${TimeUtil.getTodayDate()}", deskTopPath, header,
          body.reversed.toList());
      return 0;
    } catch (e) {
      return 1;
    }
  }

  List<String> calculateResideRate(List<String> list, RoomRecord record) {
    List<String> daily = list;
    daily[0] = TimeUtil.transMillToDate(millisconds: record.date.toInt());
    if (record.roomType == '宾馆') {
      daily[1] = "1";
    } else if (record.currencyUnit == '宽扎' && record.transType == '刷卡') {
      daily[2] = (int.parse(daily[2]) + record.realPayAmount.toInt()).toString();
      record.realPayAmount.toInt();
    }
    daily[3] = "";
    return daily;
  }

  Future<int> exportBaseData(int type, int startTime, int endTime) async {
    var deskTopPath = await FileUtils.getDesktopPath();
    List<String> header = ["序号", "房间号", "房间类型", "收费方式", "货币类型", "支付方式", "入住天数", "单价", "总计应收", "实收金额", "日期", "备注"];
    var recordList = await state.recordDao.getTimeZoneBase(startTime, endTime);
    var datas = recordList.map((e) => RoomRecord.fromJson(e)).toList();
    try {
      ExcelHelper.generateTable(
          type == 1 ? "当日基本表${TimeUtil.getTodayDate()}" : "当月基本表${TimeUtil.getTodayDate()}", deskTopPath, header, datas.reversed.toList());
      return 0;
    } catch (e) {
      return 1;
    }
  }

  Future<int> exportSummary(int type, String roomType, String currencyUnit, String transType) async {
    List<String> header = ["付款方式", "宾馆", "公寓", "小计"];
    List<String> countType = ["宽扎现金", "宽扎转账", "人民币现金", "人民币微信转账", "美元现金", "宽扎挂账"];
    List<List<String>> summary = [];
    countType.forEach((element) {
      summary.add([element,]);
    }
      if (element == "宽扎现金" || element == "宽扎转账") {
    });
    try {
      // ExcelHelper.generateTable(type == 1 ? "当日汇总表${TimeUtil.getTodayDate()}" : "当月汇总表${TimeUtil.getTodayDate(format: "yyyy-MM")}",
      //     deskTopPath, header, summary.values.toList().reversed.toList());
      return 0;
    } catch (e) {
      return 1;
    }
  }

  Future<int> countAmount(int type, String roomType, String currencyUnit, String transType, String payType) async {
    var startTime = type == 1 ? TimeUtil.getTodayStartTime() : TimeUtil.getMonthStart();
    var endTime = type == 1 ? TimeUtil.getTodayEndTime() : TimeUtil.getMonthEnd();
    var recordList = await state.recordDao.getSummary(roomType, currencyUnit, transType, startTime, endTime);
    var result = Sqflite.firstIntValue(recordList) ?? 0;
    return result;
  }

  Future<int> exportSummaryData(int type, int startTime, int endTime) async {
    List<String> header = ["日期", "宽扎现金", "宽扎刷卡", "宽扎转账", "宽扎挂账", "人民币现金", "人民币转账", "美金现金", "备注"];
    Map<String, List<String>> summary = {};
    var deskTopPath = await FileUtils.getDesktopPath();
    var recordList = await state.recordDao.getTimeZoneBase(startTime, endTime);
    var datas = recordList.map((e) => RoomRecord.fromJson(e)).toList();
    for (var record in datas) {
      var date = TimeUtil.transMillToDate(millisconds: record.date.toInt());
      summary[date] = setNewDate(summary.containsKey(date) ? summary[date]! : ["", "0", "0", "0", "0", "0", "0", "0", ""], record);
    }
    try {
      ExcelHelper.generateTable(type == 1 ? "当日汇总表${TimeUtil.getTodayDate()}" : "当月汇总表${TimeUtil.getTodayDate(format: "yyyy-MM")}",
          deskTopPath, header, summary.values.toList().reversed.toList());
      return 0;
    } catch (e) {
      return 1;
    }
  }

  List<String> setNewDate(List<String> list, RoomRecord record) {
    List<String> daily = list;
    daily[0] = TimeUtil.transMillToDate(millisconds: record.date.toInt());
    if (record.currencyUnit == '宽扎' && record.transType == '现金') {
      daily[1] = (int.parse(daily[1]) + record.realPayAmount.toInt()).toString();
    } else if (record.currencyUnit == '宽扎' && record.transType == '刷卡') {
      daily[2] = (int.parse(daily[2]) + record.realPayAmount.toInt()).toString();
      record.realPayAmount.toInt();
    } else if (record.currencyUnit == '宽扎' && record.transType == '微信转账') {
      daily[3] = (int.parse(daily[3]) + record.realPayAmount.toInt()).toString();
      record.realPayAmount.toInt();
    } else if (record.currencyUnit == '宽扎' && record.transType == '挂账') {
      daily[4] = (int.parse(daily[4]) + record.realPayAmount.toInt()).toString();
      record.realPayAmount.toInt();
    } else if (record.currencyUnit == '人民币' && record.transType == '现金') {
      daily[5] = (int.parse(daily[5]) + record.realPayAmount.toInt()).toString();
      record.realPayAmount.toInt();
    } else if (record.currencyUnit == '人民币' && record.transType == '微信转账') {
      daily[6] = (int.parse(daily[6]) + record.realPayAmount.toInt()).toString();
      record.realPayAmount.toInt();
    } else if (record.currencyUnit == '美金' && record.transType == '现金') {
      daily[7] = (int.parse(daily[7]) + record.realPayAmount.toInt()).toString();
      record.realPayAmount.toInt();
    }
    return daily;
  }

  void addRemarkInputListener() {
    state.remarkController.addListener(() {
      if (state.lastInput != state.remarkController.completeText) {
        state.lastInput = state.remarkController.completeText;
        changeRemark(state.lastInput);
      }
    });
  }

  void refreshList({int index = 1}) async {
    var recordList = await state.recordDao.getTwentyItems(index);
    state.count = await queryAllCount();
    state.recordList = recordList.map((e) => RoomRecord.fromJson(e)).toList();
    update();
  }

  void changePayType(String value) {
    state.record = state.record.copyWith(payType: value, currencyUnit: value == "挂账" ? "宽扎" : "宽扎", transType: value == "挂账" ? "挂账" : "现金");
    update();
  }

  void changeCurrencyUnit(String value) {
    state.record = state.record.copyWith(currencyUnit: value, transType: state.record.payType == "挂账" ? "挂账" : "现金");
    var price = 0;
    for (var element in state.rooms) {
      if (element.no == state.record.roomNo) {
        switch (state.record.currencyUnit) {
          case "宽扎":
            price = state.kzPrice[element.level];
            break;
          case "人民币":
            price = state.rmbPrice[element.level];
            break;
          case "美元":
            price = state.dollarPrice[element.level];
            break;
        }
      }
    }
    changePrice(price);
    update();
  }

  void changeTransType(String transType) {
    state.record = state.record.copyWith(transType: transType);
    update();
  }

  void addition() {
    var days = state.record.livingDays + 1;
    state.record =
        state.record.copyWith(amountPrice: state.record.price * days, livingDays: days, realPayAmount: state.record.price * days);
    state.realIncomeController.text = (state.record.price * days).toString();
    update();
  }

  void subtraction() {
    if (state.record.livingDays > 1) {
      var living = state.record.livingDays - 1;
      state.record =
          state.record.copyWith(amountPrice: state.record.price * living, livingDays: living, realPayAmount: state.record.price * living);
      state.realIncomeController.text = (state.record.price * living).toString();
    }
    update();
  }

  void changePrice(int price) {
    state.record =
        state.record.copyWith(price: price, amountPrice: price * state.record.livingDays, realPayAmount: price * state.record.livingDays);
    state.realIncomeController.text = (price * state.record.livingDays).toString();
    state.priceController.text = price.toString();
    update();
  }

  void changeRealPay(int price) {
    state.record = state.record.copyWith(realPayAmount: price);
    update();
  }

  void changeRemark(String remark) {
    state.remarkController.text = remark;
    state.record = state.record.copyWith(remark: remark);
    update();
  }

  void changedDate(value) {
    state.record = state.record.copyWith(date: TimeUtil.transDateToMill(date: value));
    update();
  }

  void changeRoom(int roomNo, String roomType) {
    state.record = state.record.copyWith(roomNo: roomNo, roomType: roomType);
    update();
  }

  void updateRecord(RoomRecord record) async {
    await state.recordDao.update(record);
    refreshList();
    update();
  }

  Future<int> queryAllCount() async {
    var count = Sqflite.firstIntValue(await state.recordDao.count()) ?? 1;
    return (count + Constants.pageSize - 1) ~/ Constants.pageSize;
  }

  void delRecord(int id) async {
    await state.recordDao.delete(id);
    refreshList();
    update();
  }

  void nextPage() async {
    var count = await queryAllCount();
    if (state.index < count) {
      state.index = state.index + 1;
      var recordList = await state.recordDao.getTwentyItems(state.index);
      state.recordList = recordList.map((e) => RoomRecord.fromJson(e)).toList();
      update();
    }
  }

  void lastPage() async {
    if (state.index > 1) {
      state.index = state.index - 1;
      var recordList = await state.recordDao.getTwentyItems(state.index);
      state.recordList = recordList.map((e) => RoomRecord.fromJson(e)).toList();
      update();
    }
  }

  void showToast(BuildContext context, {String text = "生成成功"}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      content: Text(text),
    ));
  }
}
