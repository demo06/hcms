import 'package:flutter/cupertino.dart';
import 'package:hcms/model/room.dart';

class CheckInState {
  late TextEditingController realIncomeController;
  late TextEditingController lowKzController;

  late TextEditingController midKzController;

  late TextEditingController highKzController;

  late TextEditingController lowDollarController;

  late TextEditingController midDollarController;

  late TextEditingController highDollarController;

  late TextEditingController lowRmbController;

  late TextEditingController midRmbController;

  late TextEditingController highRmbController;

  late String payType; //1.实收  2.预收
  late String currencyUnit; //1.宽扎 2.人民币 3.美元
  late String transType; //转账类型 1.现金 2.微信转账 3.挂账 4.刷卡
  late int living; //入住天数
  late String defaultLiving;

  late int amount; //总价
  late int price; //单价
  late String realIncome; //实收

  late List<Room> rooms;

  late List<int> dollarPrice;
  late List<int> rmbPrice;

  late List<int> kzPrice;

  CheckInState() {
    realIncomeController = TextEditingController();
    lowKzController = TextEditingController();
    midKzController = TextEditingController();
    highKzController = TextEditingController();
    lowDollarController = TextEditingController();
    midDollarController = TextEditingController();
    highDollarController = TextEditingController();
    lowRmbController = TextEditingController();
    midRmbController = TextEditingController();
    highRmbController = TextEditingController();

    payType = "实收"; //1.实收  2.预收
    currencyUnit = "宽扎"; //1.宽扎 2.人民币 3.美元
    transType = "现金"; //转账类型 1.现金 2.微信转账 3.挂账
    living = 1; //入住天数
    defaultLiving = "201";
    amount = 0; //总价
    price = 0; //单价
    realIncome = "0"; //实收

    rooms = [
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

    dollarPrice = [39, 53, 72];
    rmbPrice = [280, 380, 518];
    kzPrice = [32000, 43000, 59000];
  }
}
