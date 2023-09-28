import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  var result =await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  print(result.toString());
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 80,
                    itemBuilder: (context, index) {
                      return Container(
                          color: index % 2 == 0 ? Colors.red : Colors.blue, child: const Row(children: [Text("aaa")]));
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<RecordLogic>();
    super.dispose();
  }
}
