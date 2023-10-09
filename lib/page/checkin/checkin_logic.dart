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
    for (var element in state.rooms) {
      if (element.no.toString() == state.defaultLiving) {
        switch (state.currencyUnit) {
          case "宽扎":
            state.price = state.kzPrice[element.level];
            break;
          case "人民币":
            state.price = state.rmbPrice[element.level];
            break;
          case "美元":
            state.price = state.dollarPrice[element.level];
            break;
        }
      }
    }
    state.amount = state.price * state.living;
  }

  void changedEntryType(value) {
    state.payType = value;
    update();
  }

  void changedCurrencyUnit(value) {
    state.currencyUnit = value;
    changedPrice();
    update();
  }

  void changedPayType(value) {
    state.transType = value;
    update();
  }

  void addition() {
    state.living = state.living + 1;
    state.amount = state.price * state.living;
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
    if (state.living > 1) {
      state.living = state.living - 1;
      state.amount = state.price * state.living;
    }
    update();
  }

  void chooseRoom(int index) {
    state.defaultLiving = state.rooms[index].no.toString();
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
    state.realIncome = state.realIncomeController.text;
    return state.realIncome.isNum;
  }

  void resetDefaultValue() {
    state.payType = "实收"; //1.实收 2.预收
    state.currencyUnit = "宽扎"; //1.宽扎 2.人民币 3.美元
    state.transType = "现金"; //转账类型 1.现金 2.微信转账 3.挂账
    state.living = 1; //入住天数
    state.defaultLiving = "201";
    state.amount = 0;
    changedPrice();
    update();
  }

  void insertRecord() {
    DB.instance.recordDao.insert(RoomRecord(remark: state.remarkController.text));
  }
}
