import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hcms/page/record/record_logic.dart';
import 'package:hcms/utils/time_util.dart';
import 'package:hcms/widget/number_view.dart';
import 'package:hcms/widget/radio_button.dart';

import '../../model/record.dart';

class EditDialog extends StatefulWidget {
  late RoomRecord record;

  EditDialog({super.key, required this.record});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final logic = Get.put(RecordLogic());
  final state = Get.find<RecordLogic>().state;

  var lastInput = "";

  @override
  void initState() {
    logic.initData(widget.record);
    logic.addRemarkInputListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("编辑"),
      content: SizedBox(
          width: MediaQuery.of(context).size.width - 200,
          height: MediaQuery.of(context).size.height - 180,
          child: GetBuilder<RecordLogic>(
            builder: (logic) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 80,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(child: Text("收费方式:")),
                          Expanded(
                              child: RadioButton(
                                  title: "实收",
                                  type: state.record.payType,
                                  onPressed: () {
                                    logic.changePayType("实收");
                                  })),
                          Expanded(
                              child: RadioButton(
                                  title: "预收",
                                  type: state.record.payType,
                                  onPressed: () {
                                    logic.changePayType("预收");
                                  })),
                          Expanded(
                              child: RadioButton(
                                  title: "挂账",
                                  type: state.record.payType,
                                  onPressed: () {
                                    logic.changePayType("挂账");
                                  })),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text("结算货币种类:")),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: _currencyUnit(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text("支付方式:")),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: _transType(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text("入住天数:")),
                          Expanded(
                              flex: 1,
                              child: NumberView(
                                  number: state.record.livingDays.toInt(),
                                  addition: null, //logic.addition(),
                                  subtraction: null //logic.subtraction()
                                  )),
                          const Expanded(flex: 1, child: Text("")),
                          const Expanded(flex: 1, child: Text("")),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text("房间结算单价:")),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextField(
                                decoration: const InputDecoration(hintText: "请输入收款金额"),
                                controller: state.priceController,
                                onChanged: (value) {
                                  if (!state.priceController.value.isComposingRangeValid) {
                                    if (value.isNum) {
                                      state.priceController.text = value;
                                      logic.changePrice(int.parse(value));
                                    }
                                  }
                                }),
                          )),
                          const Expanded(flex: 1, child: Text("总计应收:")),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "${state.record.amountPrice}",
                                style: const TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.w700),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text("实收金额:")),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextField(
                                decoration: const InputDecoration(hintText: "请输入收款金额"),
                                controller: state.realIncomeController,
                                onChanged: (value) {
                                  if (!state.realIncomeController.value.isComposingRangeValid) {
                                    if (value.isNum) {
                                      state.realIncomeController.text = value;
                                      logic.changeRealPay(int.parse(value));
                                    }
                                  }
                                }),
                          )),
                          const Expanded(flex: 1, child: Text("备注:")),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextField(
                              decoration: const InputDecoration(hintText: "请输入备注"),
                              controller: state.remarkController,
                            ),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text("日期:")),
                          Expanded(
                              child: RadioButton(
                                  title: TimeUtil.transMillToDate(millisconds: state.record.date.toInt()),
                                  type: TimeUtil.transMillToDate(millisconds: state.record.date.toInt()),
                                  onPressed: () async {
                                    var result = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.fromMillisecondsSinceEpoch(state.record.date.toInt()),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    logic.changedDate(TimeUtil.transMillToDate(
                                        millisconds:
                                            result?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch));
                                  })),
                          const Expanded(flex: 1, child: Text("")),
                          const Expanded(flex: 1, child: Text("")),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          height: 230,
                          color: const Color(0XFFF2F2F2),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2.5,
                            ),
                            itemCount: state.rooms.length,
                            itemBuilder: (context, index) {
                              return RadioButton(
                                  title: state.rooms[index].no.toString(),
                                  type: state.record.roomNo.toString(),
                                  onPressed: () {
                                    logic.changeRoom(state.rooms[index].no, state.rooms[index].type);
                                  });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, '取消'),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, '确定');
            logic.updateRecord(state.record);
          },
          child: const Text('确定'),
        ),
      ],
    );
  }

  List<Widget> _transType() {
    List<Widget> widgets = [];
    if (state.record.payType == "挂账") {
      widgets = [
        Expanded(
            child: RadioButton(
                title: "挂账",
                type: state.record.transType,
                onPressed: () {
                  logic.changePayType("挂账");
                })),
        const Expanded(child: Text("")),
        const Expanded(child: Text("")),
        const Expanded(child: Text(""))
      ];
    } else {
      switch (state.record.currencyUnit) {
        case "宽扎":
          widgets = [
            Expanded(
                child: RadioButton(
                    title: "现金",
                    type: state.record.transType,
                    onPressed: () {
                      logic.changeTransType("现金");
                    })),
            Expanded(
                child: RadioButton(
                    title: "转账",
                    type: state.record.transType,
                    onPressed: () {
                      logic.changeTransType("转账");
                    })),
            Expanded(
                child: RadioButton(
                    title: "刷卡",
                    type: state.record.transType,
                    onPressed: () {
                      logic.changeTransType("刷卡");
                    })),
            const Expanded(child: Text("")),
          ];
          break;
        case "人民币":
          widgets = [
            Expanded(
                child: RadioButton(
                    title: "现金",
                    type: state.record.transType,
                    onPressed: () {
                      logic.changeTransType("现金");
                    })),
            Expanded(
                child: RadioButton(
                    title: "微信转账",
                    type: state.record.transType,
                    onPressed: () {
                      logic.changeTransType("微信转账");
                    })),
            const Expanded(child: Text("")),
            const Expanded(child: Text(""))
          ];
          break;
        case "美元":
          widgets = [
            Expanded(
                child: RadioButton(
                    title: "现金",
                    type: state.record.transType,
                    onPressed: () {
                      logic.changeTransType("现金");
                    })),
            const Expanded(child: Text("")),
            const Expanded(child: Text("")),
            const Expanded(child: Text(""))
          ];
          break;
      }
    }
    return widgets;
  }

  List<Widget> _currencyUnit() {
    List<Widget> widgets = [];
    if (state.record.payType == "挂账") {
      widgets = [
        Expanded(
            child: RadioButton(
                title: "宽扎",
                type: state.record.currencyUnit,
                onPressed: () {
                  logic.changeCurrencyUnit("宽扎");
                })),
        const Expanded(child: Text("")),
        const Expanded(child: Text(""))
      ];
    } else {
      widgets = [
        Expanded(
            child: RadioButton(
                title: "宽扎",
                type: state.record.currencyUnit,
                onPressed: () {
                  logic.changeCurrencyUnit("宽扎");
                })),
        Expanded(
            child: RadioButton(
                title: "人民币",
                type: state.record.currencyUnit,
                onPressed: () {
                  logic.changeCurrencyUnit("人民币");
                })),
        Expanded(
            child: RadioButton(
                title: "美元",
                type: state.record.currencyUnit,
                onPressed: () {
                  logic.changeCurrencyUnit("美元");
                })),
      ];
    }
    return widgets;
  }
}
