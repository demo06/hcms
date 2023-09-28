import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcms/page/checkin/checkin_logic.dart';
import 'package:hcms/widget/number_view.dart';
import 'package:hcms/widget/radio_button.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final logic = Get.put(CheckInLogic());
  final state = Get.find<CheckInLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckInLogic>(
      builder: (logic) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 80,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    "收银信息录入",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(child: Text("收费方式:")),
                    Expanded(
                        child: RadioButton(
                            title: "实收",
                            type: state.payType,
                            onPressed: () {
                              logic.changedEntryType("实收");
                            })),
                    Expanded(
                        child: RadioButton(
                            title: "预收",
                            type: state.payType,
                            onPressed: () {
                              logic.changedEntryType("预收");
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
                            type: state.currencyUnit,
                            onPressed: () {
                              logic.changedCurrencyUnit("宽扎");
                            })),
                    Expanded(
                        child: RadioButton(
                            title: "人民币",
                            type: state.currencyUnit,
                            onPressed: () {
                              logic.changedCurrencyUnit("人民币");
                            })),
                    Expanded(
                        child: RadioButton(
                            title: "美元",
                            type: state.currencyUnit,
                            onPressed: () {
                              logic.changedCurrencyUnit("美元");
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
                                  type: state.transType,
                                  onPressed: () {
                                    logic.changedPayType("现金");
                                  })),
                          Expanded(
                              child: RadioButton(
                                  title: "微信转账",
                                  type: state.transType,
                                  onPressed: () {
                                    logic.changedPayType("微信转账");
                                  })),
                          Expanded(
                              child: RadioButton(
                                  title: "挂账",
                                  type: state.transType,
                                  onPressed: () {
                                    logic.changedPayType("挂账");
                                  })),
                          Expanded(
                              child: RadioButton(
                                  title: "刷卡",
                                  type: state.transType,
                                  onPressed: () {
                                    logic.changedPayType("刷卡");
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text("入住天数:")),
                    Expanded(flex: 1, child: NumberView(number: state.living, addition: logic.addition, subtraction: logic.subtraction)),
                    const Expanded(flex: 1, child: Text("设置单价:")),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text("设置房间单价"),
                                    content: buildDialogLayout(context),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, '取消'),
                                        child: const Text('取消'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          logic.changeTodayPrice();
                                          Navigator.pop(context, '确定');
                                        },
                                        child: const Text('确定'),
                                      ),
                                    ],
                                  )),
                          child: const Text(
                            "设置今日单价",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                            ),
                          ),
                        ))
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text("房间结算单价:")),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        "${state.price}",
                        style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    )),
                    const Expanded(flex: 1, child: Text("总计应收:")),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "${state.amount}",
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
                            state.remarkController.text = value;
                          }),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    height: 240,
                    color: const Color(0XFFF2F2F2),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.0,
                      ),
                      itemCount: state.rooms.length,
                      itemBuilder: (context, index) {
                        return RadioButton(
                            title: state.rooms[index].no.toString(),
                            type: state.defaultLiving,
                            onPressed: () {
                              logic.chooseRoom(index);
                            });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: RadioButton(
                              title: "重置选项",
                              type: "添加",
                              onPressed: () {
                                logic.resetDefaultValue();
                              })),
                      Expanded(
                          flex: 1,
                          child: RadioButton(
                              title: "录入系统",
                              type: "录入系统",
                              onPressed: () {
                                logic.showToast(context, "添加成功");
                              })),
                    ],
                  ),
                )
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
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(children: [Text("公寓", style: TextStyle(fontWeight: FontWeight.w700))]),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: state.lowKzController,
                      onChanged: (value) {
                        setState(() {
                          //todo 这里放到logic中去 以下同理
                          state.lowKzController.text = value;
                          state.kzPrice[0] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "宽扎", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                        controller: state.lowRmbController,
                        onChanged: (value) {
                          setState(() {
                            state.lowRmbController.text = value;
                            state.rmbPrice[0] = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: "人民币", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                  ),
                ),
                Expanded(
                  child: TextField(
                      controller: state.lowDollarController,
                      onChanged: (value) {
                        setState(() {
                          state.lowDollarController.text = value;
                          state.dollarPrice[0] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "美元", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(children: [Text("宾馆", style: TextStyle(fontWeight: FontWeight.w700))]),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: state.midKzController,
                      onChanged: (value) {
                        setState(() {
                          state.midKzController.text = value;
                          state.kzPrice[1] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "宽扎", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                        controller: state.midRmbController,
                        onChanged: (value) {
                          setState(() {
                            state.midRmbController.text = value;
                            state.rmbPrice[1] = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: "人民币", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                  ),
                ),
                Expanded(
                  child: TextField(
                      controller: state.midDollarController,
                      onChanged: (value) {
                        setState(() {
                          state.midDollarController.text = value;
                          state.dollarPrice[1] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "美元", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(children: [Text("高级套房", style: TextStyle(fontWeight: FontWeight.w700))]),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: state.highKzController,
                      onChanged: (value) {
                        setState(() {
                          state.highKzController.text = value;
                          state.kzPrice[2] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "宽扎", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                        controller: state.highRmbController,
                        onChanged: (value) {
                          setState(() {
                            state.highRmbController.text = value;
                            state.rmbPrice[2] = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: "人民币", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                  ),
                ),
                Expanded(
                  child: TextField(
                      controller: state.highDollarController,
                      onChanged: (value) {
                        setState(() {
                          state.highDollarController.text = value;
                          state.dollarPrice[2] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "美元", contentPadding: EdgeInsets.all(4), border: OutlineInputBorder(gapPadding: 0))),
                ),
              ],
            )
          ],
        ));
  }

  @override
  void dispose() {
    Get.delete<CheckInLogic>();
    super.dispose();
  }
}
