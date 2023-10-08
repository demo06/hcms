import 'package:flutter/material.dart';
import 'package:hcms/model/record.dart';
import 'package:hcms/model/room.dart';
import 'package:hcms/utils/db_helper.dart';

import '../../dao/record_dao.dart';

class RecordState {
  late List<RoomRecord> recordList = [];

  late RoomRecord record;
  late List<Room> rooms;

  late List<int> dollarPrice;
  late List<int> rmbPrice;

  late List<int> kzPrice;

  late TextEditingController priceController;
  late TextEditingController remarkController;
  late TextEditingController realIncomeController;

  late RecordDao recordDao = DB.instance.recordDao;

  RecordState() {
    priceController = TextEditingController();
    remarkController = TextEditingController();
    realIncomeController = TextEditingController();

    record = RoomRecord(
        roomNo: 201,
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
