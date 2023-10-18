import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/utils/time_util.dart';
import 'package:hcms/widget/radio_button.dart';

import '../edit/eidt_dialog.dart';
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
              const Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Text(
                  "入住信息导出",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioButton(
                      title: "宾馆当月入住率",
                      type: "宾馆当月入住率",
                      onPressed: () async {
                        var result = await logic.exportMonthResideRate(1);
                        logic.showToast(context, text: result == 0 ? "导出成功" : "导出失败");
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioButton(
                      title: "当日汇总",
                      type: "当日汇总",
                      onPressed: () async {
                        var result =
                            await logic.exportSummaryData(1, TimeUtil.getTodayStartTime(), TimeUtil.getTodayEndTime());
                        logic.showToast(context, text: result == 0 ? "导出成功" : "导出失败");
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioButton(
                      title: "当日基本数据",
                      type: "当日基本数据",
                      onPressed: () async {
                        var result =
                            await logic.exportBaseData(1, TimeUtil.getTodayStartTime(), TimeUtil.getTodayEndTime());
                        logic.showToast(context, text: result == 0 ? "导出成功" : "导出失败");
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioButton(
                      title: "公寓当月入住率",
                      type: "公寓当月入住率",
                      onPressed: () async {
                        var result = await logic.exportMonthResideRate(2);
                        logic.showToast(context, text: result == 0 ? "导出成功" : "导出失败");
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioButton(
                      title: "当月汇总",
                      type: "当月汇总",
                      onPressed: () async {
                        var result = await logic.exportSummary(2, "宾馆","宽扎" ,"现金");
                        logic.showToast(context, text: result == 0 ? "导出成功" : "导出失败");
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioButton(
                      title: "当月基本数据",
                      type: "当月基本数据",
                      onPressed: () async {
                        var result = await logic.exportBaseData(2, TimeUtil.getMonthStart(), TimeUtil.getMonthEnd());
                        logic.showToast(context, text: result == 0 ? "导出成功" : "导出失败");
                      },
                    ),
                  ),
                ],
              ),
              Container(
                color: const Color(0XFFE4E4E4),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.1)),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: _cell(title: "序号", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "房间号", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "房间类型", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "收费方式", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "货币类型", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "支付方式", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "入住天数", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "单价", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "总计应收", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "实收金额", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "日期", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "备注", isTitle: true)),
                      Expanded(flex: 1, child: _cell(title: "操作", isTitle: true)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 342,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.recordList.length,
                    itemBuilder: (context, index) {
                      return _row(state.recordList[index]);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        logic.lastPage();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        side: const BorderSide(color: Colors.red),
                        backgroundColor: Colors.red,
                      ),
                      child: const Icon(
                        Icons.navigate_before_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26, right: 26),
                      child: Text("${state.index}/${state.count}", style: const TextStyle(color: Colors.grey)),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        logic.nextPage();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        side: const BorderSide(color: Colors.red),
                        backgroundColor: Colors.red,
                      ),
                      child: const Icon(
                        Icons.navigate_next_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _row(RoomRecord record) {
    return Row(
      children: [
        Expanded(flex: 1, child: _cell(title: record.id.toString())),
        Expanded(flex: 1, child: _cell(title: record.roomNo.toString())),
        Expanded(flex: 1, child: _cell(title: record.roomType.toString())),
        Expanded(flex: 1, child: _cell(title: record.payType.toString())),
        Expanded(flex: 1, child: _cell(title: record.currencyUnit.toString())),
        Expanded(flex: 1, child: _cell(title: record.transType.toString())),
        Expanded(flex: 1, child: _cell(title: record.livingDays.toString())),
        Expanded(flex: 1, child: _cell(title: record.price.toString())),
        Expanded(flex: 1, child: _cell(title: record.amountPrice.toString())),
        Expanded(flex: 1, child: _cell(title: record.realPayAmount.toString())),
        Expanded(
            flex: 1,
            child: _cell(title: TimeUtil.transMillToDate(millisconds: record.date.toInt(), format: 'yyyy-MM-dd'))),
        Expanded(flex: 1, child: _cell(title: record.remark.toString())),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: _cell(
                  title: "编辑",
                  isEdit: true,
                  onClick: () => showDialog<String>(
                      context: context, builder: (BuildContext context) => EditDialog(record: record)),
                )),
                Expanded(
                    child: _cell(
                  title: "删除",
                  isEdit: true,
                  onClick: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("删除记录"),
                            content: const Text("你确认删除该条记录吗?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, '取消'),
                                child: const Text('取消'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context, '确定');
                                  logic.delRecord(record.id.toInt());
                                },
                                child: const Text('确定'),
                              ),
                            ],
                          )),
                ))
              ],
            ))
      ],
    );
  }

  Widget _cell({required String title, bool isTitle = false, bool isEdit = false, VoidCallback? onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: isTitle
                  ? Border.all(color: Colors.black, width: 0.1)
                  : const Border(bottom: BorderSide(color: Color(0XFFDEDEDE)))),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: isTitle ? 14 : 12, color: isEdit ? Colors.blue : Colors.black),
            ),
          )),
    );
  }

  @override
  void dispose() {
    Get.delete<RecordLogic>();
    super.dispose();
  }
}
