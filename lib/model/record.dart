/// id : 1
/// roomNum : 1
/// payType : "ss"
/// roomType : "宾馆"
/// currencyUnit : "ss"
/// livingDays : 11
/// price : 1
/// amountPrice : 22
/// transType : "ss"
/// realPayAmount : 1
/// date : 1232223333333
/// remark : ""

class RoomRecord {
  RoomRecord({
    num? id,
    num? roomNo,
    String? payType,
    String? roomType,
    String? currencyUnit,
    num? livingDays,
    num? price,
    num? amountPrice,
    String? transType,
    num? realPayAmount,
    num? date,
    String? remark,
  }) {
    _id = id;
    _roomNo = roomNo;
    _payType = payType;
    _roomType = roomType;
    _currencyUnit = currencyUnit;
    _livingDays = livingDays;
    _price = price;
    _amountPrice = amountPrice;
    _transType = transType;
    _realPayAmount = realPayAmount;
    _date = date;
    _remark = remark;
  }

  RoomRecord.fromJson(dynamic json) {
    _id = json['id'];
    _roomNo = json['roomNo'];
    _payType = json['payType'];
    _roomType = json['roomType'];
    _currencyUnit = json['currencyUnit'];
    _livingDays = json['livingDays'];
    _price = json['price'];
    _amountPrice = json['amountPrice'];
    _transType = json['transType'];
    _realPayAmount = json['realPayAmount'];
    _date = json['date'];
    _remark = json['remark'];
  }

  num? _id;
  num? _roomNo;
  String? _payType;
  String? _roomType;
  String? _currencyUnit;
  num? _livingDays;
  num? _price;
  num? _amountPrice;
  String? _transType;
  num? _realPayAmount;
  num? _date;
  String? _remark;

  RoomRecord copyWith({
    num? id,
    num? roomNo,
    String? payType,
    String? roomType,
    String? currencyUnit,
    num? livingDays,
    num? price,
    num? amountPrice,
    String? transType,
    num? realPayAmount,
    num? date,
    String? remark,
  }) =>
      RoomRecord(
        id: id ?? _id,
        roomNo: roomNo ?? _roomNo,
        payType: payType ?? _payType,
        roomType: roomType ?? _roomType,
        currencyUnit: currencyUnit ?? _currencyUnit,
        livingDays: livingDays ?? _livingDays,
        price: price ?? _price,
        amountPrice: amountPrice ?? _amountPrice,
        transType: transType ?? _transType,
        realPayAmount: realPayAmount ?? _realPayAmount,
        date: date ?? _date,
        remark: remark ?? _remark,
      );

  num get id => _id ?? 0;

  num get roomNo => _roomNo ?? 0;

  String get payType => _payType ?? "";

  String get roomType => _roomType ?? "";

  String get currencyUnit => _currencyUnit ?? "";

  num get livingDays => _livingDays ?? 0;

  num get price => _price ?? 0;

  num get amountPrice => _amountPrice ?? 0;

  String get transType => _transType ?? "";

  num get realPayAmount => _realPayAmount ?? 0;

  num get date => _date ?? 0;

  String get remark => _remark ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['roomNo'] = _roomNo;
    map['payType'] = _payType;
    map['roomType'] = _roomType;
    map['currencyUnit'] = _currencyUnit;
    map['livingDays'] = _livingDays;
    map['price'] = _price;
    map['amountPrice'] = _amountPrice;
    map['transType'] = _transType;
    map['realPayAmount'] = _realPayAmount;
    map['date'] = _date;
    map['remark'] = _remark;
    return map;
  }
}
