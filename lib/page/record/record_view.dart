import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/utils/TimeUtil.dart';
import 'package:hcms/widget/radio_button.dart';

import 'record_logic.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final logic = Get.put(RecordLogic());
  final state = Get.find<RecordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordLogic>(
      assignId: true,
      builder: (logic) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              RadioButton(
                title: "选择时间",
                type: "选择时间",
                onPressed: () async {
                  var result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  print(result.toString());
                },
              ),
              Container(
                color: const Color(0XFFE4E4E4),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.1)),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: _cell(title: "房间号", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "房间类型", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "收费方式", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "货币类型", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "入住天数", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "单价", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "总计应收", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "支付方式", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "实收金额", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "日期", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "备注", isTitle: true)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 240,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.recordList.length,
                    itemBuilder: (context, index) {
                      return _row(state.recordList[index]);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _row(RoomRecord record) {
    return Row(
      children: [
        Expanded(flex: 1, child: _cell(title: record.roomNum.toString())),
        Expanded(flex: 1, child: _cell(title: record.roomType.toString())),
        Expanded(flex: 1, child: _cell(title: record.payType.toString())),
        Expanded(flex: 1, child: _cell(title: record.currencyUnit.toString())),
        Expanded(flex: 1, child: _cell(title: record.livingDays.toString())),
        Expanded(flex: 1, child: _cell(title: record.price.toString())),
        Expanded(flex: 1, child: _cell(title: record.amountPrice.toString())),
        Expanded(flex: 1, child: _cell(title: record.transType.toString())),
        Expanded(flex: 1, child: _cell(title: record.realPayAmount.toString())),
        Expanded(
            flex: 1,
            child: _cell(title: TimeUtil().transMillToDate(millisconds: record.date.toInt(), format: 'yyyy-MM-dd'))),
        Expanded(flex: 1, child: _cell(title: record.remark.toString())),
      ],
    );
  }

  Widget _cell({required String title, bool isTitle = false}) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
        border: isTitle ? Border.all(color: Colors.black, width: 0.1) : const Border(bottom: BorderSide(color: Color(0XFFDEDEDE)))),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: isTitle ? 14 : 12, color: Colors.black),
          ),
        ));
  }

  @override
  void dispose() {
    Get.delete<RecordLogic>();
    super.dispose();
  }
}
