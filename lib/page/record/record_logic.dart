import 'package:get/get.dart';
import 'package:hcms/global/constants.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/utils/db_helper.dart';
import 'package:hcms/utils/excel_helper.dart';
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

  void exportDaily() async {
    List<String> header = ["序号", "房间号", "房间类型", "收费方式", "货币类型", "入住天数", "单价", "总计应收", "支付方式", "实收金额", "日期", "备注"];
    var recordList = await state.recordDao.getTwentyItems(1);
    var datas = recordList.map((e) => RoomRecord.fromJson(e)).toList();
    ExcelHelper.generateTable("D:\\1", header, datas);
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

  void changePayType(String payType) {
    state.record = state.record.copyWith(payType: payType);
    update();
  }

  void changeCurrencyUnit(String currencyUnit) {
    state.record = state.record.copyWith(currencyUnit: currencyUnit);
    update();
  }

  void changeTransType(String transType) {
    state.record = state.record.copyWith(transType: transType);
    update();
  }

  void addition() {
    var days = state.record.livingDays + 1;
    state.record = state.record.copyWith(livingDays: days, amountPrice: state.record.price * days);
    update();
  }

  void subtraction() {
    var days = state.record.livingDays - 1;
    if (days > 1) {
      state.record = state.record.copyWith(livingDays: days, amountPrice: state.record.price * days);
    }
    update();
  }

  void changePrice(int price) {
    state.record = state.record.copyWith(price: price, amountPrice: price * state.record.livingDays);
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
}
