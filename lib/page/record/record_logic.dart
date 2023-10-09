import 'package:get/get.dart';
import 'package:hcms/model/record.dart';

import 'record_state.dart';

class RecordLogic extends GetxController {
  final RecordState state = RecordState();

  @override
  void onInit() {
    refreshList();
    super.onInit();
  }

  void initData(RoomRecord record) {
    state.record = record;
    state.priceController.text = record.price.toString();
    state.realIncomeController.text = record.realPayAmount.toString();
    state.remarkController.text = record.remark.toString();
  }

  void addRemarkInputListener() {
    state.remarkController.addListener(() {
      if (state.lastInput != state.remarkController.completeText) {
        state.lastInput = state.remarkController.completeText;
        changeRemark(state.lastInput);
      }
    });
  }

  void refreshList({int index = 0}) async {
    var recordList = await state.recordDao.queryAll();
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

  void delRecord(int id) async {
    await state.recordDao.delete(id);
    refreshList();
    update();
  }
}
