import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/page/record/record_logic.dart';

import '../../widget/number_view.dart';
import '../../widget/radio_button.dart';

class EditPage extends StatefulWidget {
  late RoomRecord record;

  EditPage({Key? key, required this.record}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final logic = Get.put(RecordLogic());
  final state = Get.find<RecordLogic>().state;

  @override
  void initState() {
    super.initState();
    setState(() {
      state.record = widget.record;
      state.priceController.text = widget.record.price.toString();
      state.realIncomeController.text = widget.record.realPayAmount.toString();
      state.remarkController.text = widget.record.remark.toString();
      print("dialog1==>${widget.record.toString()}");
      print("dialog==>${state.record.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordLogic>(
      builder: (logic) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
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
                    const Expanded(child: Text("")),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: Text("结算货币种类:")),
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
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text("支付方式:")),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
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
                          Expanded(
                              child: RadioButton(
                                  title: "挂账",
                                  type: state.record.transType,
                                  onPressed: () {
                                    logic.changeTransType("挂账");
                                  })),
                          Expanded(
                              child: RadioButton(
                                  title: "刷卡",
                                  type: state.record.transType,
                                  onPressed: () {
                                    logic.changeTransType("刷卡");
                                  })),
                        ],
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
                            addition: () => logic.addition(),
                            subtraction: () => logic.subtraction())),
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
                            state.priceController.text = value;
                            logic.changePrice(int.parse(value));
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
                            state.realIncomeController.text = value;
                            logic.changeRealPay(int.parse(value));
                          }),
                    )),
                    const Expanded(flex: 1, child: Text("备注:")),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextField(
                          decoration: const InputDecoration(hintText: "请输入备注"),
                          controller: state.remarkController,
                          onChanged: (value) {
                            logic.changeRemark(value);
                          }),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
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
    );
  }

  Container buildDialogLayout(BuildContext context) {
    return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2 - 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ));
  }

  @override
  void dispose() {
    Get.delete<RecordLogic>();
    super.dispose();
  }
}
