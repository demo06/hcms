import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/utils/db_helper.dart';
import 'checkin_state.dart';

class CheckInLogic extends GetxController {
  final CheckInState state = CheckInState();

  @override
  void onInit() {
    changedPrice();
    initInputValue();
    super.onInit();
  }

  void initInputValue() {
    state.realIncomeController.text = "0";
    state.lowKzController.text = state.kzPrice[0].toString();
    state.midKzController.text = state.kzPrice[1].toString();
    state.highKzController.text = state.kzPrice[2].toString();
    state.lowDollarController.text = state.dollarPrice[0].toString();
    state.midDollarController.text = state.dollarPrice[1].toString();
    state.highDollarController.text = state.dollarPrice[2].toString();
    state.lowRmbController.text = state.rmbPrice[0].toString();
    state.midRmbController.text = state.rmbPrice[1].toString();
    state.highRmbController.text = state.rmbPrice[2].toString();
  }

  void changedPrice() {
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
    state.record = state.record.copyWith(price: price, amountPrice: price * state.record.livingDays);
  }

  void changedEntryType(value) {
    state.record = state.record.copyWith(payType: value);
    update();
  }

  void changedCurrencyUnit(value) {
    state.record = state.record.copyWith(currencyUnit: value);
    changedPrice();
    update();
  }

  void changedPayType(value) {
    state.record = state.record.copyWith(transType: value);
    update();
  }

  void addition() {
    var living = state.record.livingDays + 1;
    state.record = state.record.copyWith(amountPrice: state.record.price * living, livingDays: living);
    update();
  }

  void changeTodayPrice() {
    state.kzPrice[0] = int.parse(state.lowKzController.text);
    state.kzPrice[1] = int.parse(state.midKzController.text);
    state.kzPrice[2] = int.parse(state.highKzController.text);
    state.rmbPrice[0] = int.parse(state.lowRmbController.text);
    state.rmbPrice[1] = int.parse(state.midRmbController.text);
    state.rmbPrice[2] = int.parse(state.highRmbController.text);
    state.dollarPrice[0] = int.parse(state.lowDollarController.text);
    state.dollarPrice[1] = int.parse(state.midDollarController.text);
    state.dollarPrice[2] = int.parse(state.highDollarController.text);
    changedPrice();
    update();
  }

  void subtraction() {
    if (state.record.livingDays > 1) {
      var living = state.record.livingDays - 1;
      state.record = state.record.copyWith(amountPrice: state.record.price * living, livingDays: living);
    }
    update();
  }

  void chooseRoom(int index) {
    state.record = state.record.copyWith(roomNo: state.rooms[index].no);
    changedPrice();
    update();
  }

  void showToast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      content: Text(checkRealIncome() ? "添加成功" : "实收现金不是数字"),
    ));
  }

  bool checkRealIncome() {
    if (state.realIncomeController.text.isNum) {
      var income = int.parse(state.realIncomeController.text);
      state.record = state.record.copyWith(realPayAmount: income);
      return true;
    } else {
      return false;
    }
  }

  void changeRemark(String remark) {
    state.remarkController.text = remark;
    state.record = state.record.copyWith(remark: remark);
    update();
  }

  void resetDefaultValue() {
    state.record = RoomRecord(
        roomNo: 201,
        roomType: "宾馆",
        payType: "实收",
        currencyUnit: "宽扎",
        livingDays: 1,
        price: 43000,
        amountPrice: 43000,
        transType: "现金",
        realPayAmount: 43000,
        date: DateTime.now().millisecondsSinceEpoch,
        remark: "");
    update();
  }

  void insertRecord(BuildContext context) {
    DB.instance.recordDao.insert(state.record);
    showToast(context, "录入成功");
  }
}
