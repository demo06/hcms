import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hcms/model/room.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _lowKzController = TextEditingController();
  final TextEditingController _midKzController = TextEditingController();
  final TextEditingController _highKzController = TextEditingController();
  final TextEditingController _lowDollarController = TextEditingController();
  final TextEditingController _midDollarController = TextEditingController();
  final TextEditingController _highDollarController = TextEditingController();
  final TextEditingController _lowRmbController = TextEditingController();
  final TextEditingController _midRmbController = TextEditingController();
  final TextEditingController _highRmbController = TextEditingController();

  String entryType = "宾馆"; //1.宾馆 2.公寓
  String currencyUnit = "宽扎"; //1.宽扎 2.人民币 3.美元
  String transType = "现金"; //转账类型 1.现金 2.微信转账 3.挂账
  int living = 1; //入住天数
  String defaultLiving = "201";
  int amount = 0; //总价
  int price = 0; //单价

  List<Room> rooms = [
    Room(201, 1, "宾馆"),
    Room(202, 1, "宾馆"),
    Room(203, 2, "宾馆"),
    Room(205, 2, "宾馆"),
    Room(206, 1, "宾馆"),
    Room(207, 1, "宾馆"),
    Room(208, 1, "宾馆"),
    Room(209, 1, "宾馆"),
    Room(210, 1, "宾馆"),
    Room(211, 1, "宾馆"),
    Room(212, 1, "宾馆"),
    Room(213, 1, "宾馆"),
    Room(215, 1, "宾馆"),
    Room(216, 1, "宾馆"),
    Room(217, 2, "宾馆"),
    Room(301, 0, "公寓"),
    Room(302, 0, "公寓"),
    Room(303, 0, "公寓"),
    Room(305, 0, "公寓"),
    Room(306, 0, "公寓"),
    Room(307, 0, "公寓"),
    Room(308, 0, "公寓"),
    Room(309, 0, "公寓"),
    Room(310, 0, "公寓"),
    Room(311, 0, "公寓"),
    Room(312, 0, "公寓"),
    Room(313, 0, "公寓"),
    Room(315, 0, "公寓")
  ];

  List<int> dollarPrice = [39, 53, 72];
  List<int> rmbPrice = [280, 380, 518];
  List<int> kzPrice = [32000, 43000, 59000];

  @override
  void initState() {
    super.initState();
    setState(() {
      _changedPrice();
      _lowKzController.text = kzPrice[0].toString();
      _midKzController.text = kzPrice[1].toString();
      _highKzController.text = kzPrice[2].toString();
      _lowDollarController.text = dollarPrice[0].toString();
      _midDollarController.text = dollarPrice[1].toString();
      _highDollarController.text = dollarPrice[2].toString();
      _lowRmbController.text = rmbPrice[0].toString();
      _midRmbController.text = rmbPrice[1].toString();
      _highRmbController.text = rmbPrice[2].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
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
              const Expanded(child: Text("入住类型:")),
              Expanded(
                child: rButton("宾馆", entryType, () {
                  _changedEntryType("宾馆");
                }),
              ),
              Expanded(
                child: rButton("公寓", entryType, () {
                  _changedEntryType("公寓");
                }),
              ),
              const Expanded(child: Text("")),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text("结算货币种类:")),
              Expanded(
                  child: rButton("宽扎", currencyUnit, () {
                _changedCurrencyUnit("宽扎");
              })),
              Expanded(
                  child: rButton("人民币", currencyUnit, () {
                _changedCurrencyUnit("人民币");
              })),
              Expanded(
                  child: rButton("美元", currencyUnit, () {
                _changedCurrencyUnit("美元");
              })),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text("支付方式:")),
              Expanded(
                  child: rButton("现金", transType, () {
                _changedPayType("现金");
              })),
              Expanded(
                  child: rButton("微信转账", transType, () {
                _changedPayType("微信转账");
              })),
              Expanded(
                  child: rButton("挂账", transType, () {
                _changedPayType("挂账");
              })),
            ],
          ),
          Row(
            children: [
              const Expanded(flex: 1, child: Text("入住天数:")),
              Expanded(flex: 1, child: tView(living, _addition, _subtraction)),
              const Expanded(flex: 1, child: Text("设置单价:")),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text("设置房间单价"),
                              content: buildContainer(context),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, '取消'),
                                  child: const Text('取消'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      kzPrice[0] =
                                          int.parse(_lowKzController.text);
                                      kzPrice[1] =
                                          int.parse(_midKzController.text);
                                      kzPrice[2] =
                                          int.parse(_highKzController.text);
                                      rmbPrice[0] =
                                          int.parse(_lowRmbController.text);
                                      rmbPrice[1] =
                                          int.parse(_midRmbController.text);
                                      rmbPrice[2] =
                                          int.parse(_highRmbController.text);
                                      dollarPrice[0] =
                                          int.parse(_lowDollarController.text);
                                      dollarPrice[1] =
                                          int.parse(_midDollarController.text);
                                      dollarPrice[2] =
                                          int.parse(_highDollarController.text);
                                      _changedPrice();
                                    });
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
              const Expanded(flex: 1, child: Text("结算单价:")),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text("$price"),
              )),
              const Expanded(flex: 1, child: Text("总计:")),
              Expanded(
                  flex: 1,
                  child: Text(
                    "$amount",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ))
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
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return rButton(rooms[index].no.toString(), defaultLiving, () {
                    setState(() {
                      defaultLiving = rooms[index].no.toString();
                      _changedPrice();
                    });
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
                  child: rButton("重置选项", "添加", () {
                    resetDefaultValue();
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: rButton("添加录入", "添加录入", () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('添加成功')));
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _changedPrice() {
    for (var element in rooms) {
      if (element.no.toString() == defaultLiving) {
        switch (currencyUnit) {
          case "宽扎":
            price = kzPrice[element.level];
            break;
          case "人民币":
            price = rmbPrice[element.level];
            break;
          case "美元":
            price = dollarPrice[element.level];
            break;
        }
      }
    }
    amount = price * living;
  }

  void _changedEntryType(value) {
    setState(() {
      entryType = value;
    });
  }

  void _changedCurrencyUnit(value) {
    setState(() {
      currencyUnit = value;
      _changedPrice();
    });
  }

  void _changedPayType(value) {
    setState(() {
      transType = value;
    });
  }

  void _addition() {
    setState(() {
      living = living + 1;
      amount = price * living;
    });
  }

  void _subtraction() {
    setState(() {
      if (living > 1) {
        living = living - 1;
        amount = price * living;
      }
    });
  }

  void resetDefaultValue() {
    setState(() {
      entryType = "宾馆"; //1.宾馆 2.公寓
      currencyUnit = "宽扎"; //1.宽扎 2.人民币 3.美元
      transType = "现金"; //转账类型 1.现金 2.微信转账 3.挂账
      living = 1; //入住天数
      defaultLiving = "201";
      amount = 0;
      _changedPrice();
    });
  }

  Container buildContainer(BuildContext context) {
    return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2 - 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(children: [
                Text("公寓", style: TextStyle(fontWeight: FontWeight.w700))
              ]),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _lowKzController,
                      onChanged: (value) {
                        setState(() {
                          _lowKzController.text = value;
                          kzPrice[0] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "宽扎",
                          contentPadding: EdgeInsets.all(4),
                          border: OutlineInputBorder(gapPadding: 0))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                        controller: _lowRmbController,
                        onChanged: (value) {
                          setState(() {
                            _lowRmbController.text = value;
                            rmbPrice[0] = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: "人民币",
                            contentPadding: EdgeInsets.all(4),
                            border: OutlineInputBorder(gapPadding: 0))),
                  ),
                ),
                Expanded(
                  child: TextField(
                      controller: _lowDollarController,
                      onChanged: (value) {
                        setState(() {
                          _lowDollarController.text = value;
                          dollarPrice[0] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "美元",
                          contentPadding: EdgeInsets.all(4),
                          border: OutlineInputBorder(gapPadding: 0))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: const [
                Text("宾馆", style: TextStyle(fontWeight: FontWeight.w700))
              ]),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _midKzController,
                      onChanged: (value) {
                        setState(() {
                          _midKzController.text = value;
                          kzPrice[1] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "宽扎",
                          contentPadding: EdgeInsets.all(4),
                          border: OutlineInputBorder(gapPadding: 0))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                        controller: _midRmbController,
                        onChanged: (value) {
                          setState(() {
                            _midRmbController.text = value;
                            rmbPrice[1] = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: "人民币",
                            contentPadding: EdgeInsets.all(4),
                            border: OutlineInputBorder(gapPadding: 0))),
                  ),
                ),
                Expanded(
                  child: TextField(
                      controller: _midDollarController,
                      onChanged: (value) {
                        setState(() {
                          _midDollarController.text = value;
                          dollarPrice[1] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "美元",
                          contentPadding: EdgeInsets.all(4),
                          border: OutlineInputBorder(gapPadding: 0))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: const [
                Text("高级套房", style: TextStyle(fontWeight: FontWeight.w700))
              ]),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _highKzController,
                      onChanged: (value) {
                        setState(() {
                          _highKzController.text = value;
                          kzPrice[2] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "宽扎",
                          contentPadding: EdgeInsets.all(4),
                          border: OutlineInputBorder(gapPadding: 0))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                        controller: _highRmbController,
                        onChanged: (value) {
                          setState(() {
                            _highRmbController.text = value;
                            rmbPrice[2] = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: "人民币",
                            contentPadding: EdgeInsets.all(4),
                            border: OutlineInputBorder(gapPadding: 0))),
                  ),
                ),
                Expanded(
                  child: TextField(
                      controller: _highDollarController,
                      onChanged: (value) {
                        setState(() {
                          _highDollarController.text = value;
                          dollarPrice[2] = int.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "美元",
                          contentPadding: EdgeInsets.all(4),
                          border: OutlineInputBorder(gapPadding: 0))),
                ),
              ],
            )
          ],
        ));
  }

  Widget rButton(String title, String type, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, left: 30, right: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: BorderSide(color: type == title ? Colors.red : Colors.grey),
          backgroundColor: type == title ? Colors.red : Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(color: type == title ? Colors.white : Colors.grey),
        ),
      ),
    );
  }

  Widget tView(int number, VoidCallback addition, VoidCallback subtraction) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
              onPressed: subtraction,
              icon: const Icon(
                Icons.indeterminate_check_box_rounded,
                color: Colors.red,
              )),
          Text("$number"),
          IconButton(
              onPressed: addition,
              icon: const Icon(
                Icons.add_box_rounded,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
