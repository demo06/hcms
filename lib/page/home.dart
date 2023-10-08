import 'package:flutter/material.dart';
import 'package:hcms/dao/record_dao.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/page/checkin/checkin_view.dart';
import 'package:hcms/page/record/record_view.dart';
import 'package:hcms/utils/db_helper.dart';
import 'package:hovering/hovering.dart';
import 'package:window_manager/window_manager.dart';

import '../model/nav.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  final PageController _transController = PageController();

  List<Navigation> navigator = [
    Navigation("收银录入", Icons.monetization_on_rounded, true),
    Navigation("入住记录", Icons.receipt_long_rounded, false),
  ];

  List<Widget> page = [
    const CheckInPage(),
    const RecordPage(),
  ];

  var data = RoomRecord(
      roomNo: 301,
      roomType: "宾馆",
      payType: "实收",
      currencyUnit: "宽扎",
      livingDays: 1,
      price: 1000,
      amountPrice: 5000,
      transType: "现金",
      realPayAmount: 1000,
      date: DateTime.now().millisecondsSinceEpoch,
      remark: "");

  @override
  void initState() {
    super.initState();
    initDate();
    windowManager.addListener(this);
  }

  Future<void> initDate() async {
    for (var i = 0; i < 100; i++) {
      await DB.instance.recordDao.insert(data);
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    _transController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) {
                windowManager.startDragging();
              },
              child: Container(
                color: const Color(0XFF333333),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width / 2,
                      child: const Row(
                        children: [
                          Text(
                            "HCMS",
                            style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.w900),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("酒店收银管理系统", style: TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                windowManager.minimize();
                              },
                              icon: const Icon(
                                Icons.minimize_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () async {
                                await windowManager.isMaximized() ? windowManager.restore() : windowManager.maximize();
                              },
                              icon: const Icon(
                                Icons.crop_7_5_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                windowManager.close();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
      body: Container(
        color: const Color(0XFFFFFFFF),
        // color: Colors.red,
        child: Row(
          children: [
            Container(
              color: const Color(0XFFF2F2F2),
              child: SizedBox(
                width: 260,
                height: MediaQuery.of(context).size.height - 40,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListView.builder(
                      itemCount: navigator.length,
                      itemBuilder: (context, index) {
                        return leftItem(navigator[index].name, navigator[index].icon, navigator[index].isSelect, () {
                          setState(() {
                            for (int i = 0; i < navigator.length; i++) {
                              navigator[i].isSelect = false;
                            }
                            navigator[index].isSelect = true;
                            _transController.animateToPage(index, //跳转到的位置
                                duration: const Duration(milliseconds: 300),
                                //跳转的间隔时间
                                curve: Curves.fastOutSlowIn);
                          });
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 260,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: _transController,
                  itemCount: navigator.length,
                  itemBuilder: (context, index) {
                    return page[index];
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget leftItem(String title, IconData icon, bool isSelect, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: HoverButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onpressed: onPressed,
        hoverElevation: 0,
        color: isSelect ? const Color(0xFFF44336) : const Color(0XFFF2F2F2),
        hoverPadding: const EdgeInsets.only(left: 8, right: 8, top: 2.5, bottom: 2.5),
        hoverColor: const Color(0xFFF44336),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 2.5, bottom: 2.5),
        child: Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 12),
                child: Icon(icon, color: Colors.black54, size: 20),
              ),
              Text(title, style: TextStyle(fontSize: 13, color: isSelect ? Colors.white : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
