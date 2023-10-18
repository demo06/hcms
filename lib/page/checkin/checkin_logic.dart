import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/utils/db_helper.dart';
import 'package:hcms/utils/time_util.dart';
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
    state.record = state.record
        .copyWith(payType: value, currencyUnit: value == "挂账" ? "宽扎" : "宽扎", transType: value == "挂账" ? "挂账" : "现金");
    update();
  }

  void changedCurrencyUnit(value) {
    state.record = state.record.copyWith(currencyUnit: value, transType: "现金");
    changedPrice();
    update();
  }

  void changedPayType(value) {
    state.record = state.record.copyWith(transType: value);
    update();
  }

  void changedDate(value) {
    state.record = state.record.copyWith(date: TimeUtil.transDateToMill(date: value));
    print(state.record);
    update();
  }

  void changeRealIncome(int value) {
    state.realIncomeController.text = value.toString();
    state.record = state.record.copyWith(realPayAmount: value);
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
    state.record = state.record.copyWith(roomNo: state.rooms[index].no, roomType: state.rooms[index].type);
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
    state.dollarPrice = [39, 53, 72];
    state.rmbPrice = [280, 380, 518];
    state.kzPrice = [32000, 43000, 59000];
    initInputValue();
    state.record = RoomRecord(
        roomNo: 201,
        roomType: "宾馆",
        payType: "实收",
        currencyUnit: "宽扎",
        livingDays: 1,
        price: 43000,
        amountPrice: 43000,
        transType: "现金",
        realPayAmount: 0,
        date: DateTime.now().millisecondsSinceEpoch,
        remark: "");
    update();
  }

  void insertRecord(BuildContext context) {
    var currentDate = state.record.date;
    if (state.record.livingDays > 1) {
      for (int i = 0; i < state.record.livingDays; i++) {
        DB.instance.recordDao.insert(state.record.copyWith(
            date: currentDate,
            livingDays: 1,
            amountPrice: state.record.price,
            realPayAmount: i == 0 ? state.record.realPayAmount : 0));
        currentDate += 86400000;
      }
      state.record = state.record.copyWith(date: currentDate);
    } else {
      DB.instance.recordDao.insert(state.record);
    }
    showToast(context, "录入成功");
  }
}
