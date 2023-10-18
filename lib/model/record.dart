import 'package:hcms/utils/time_util.dart';

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
    String? transType,
    num? livingDays,
    num? price,
    num? amountPrice,
    num? realPayAmount,
    num? date,
    String? remark,
  }) {
    _id = id;
    _roomNo = roomNo;
    _payType = payType;
    _roomType = roomType;
    _currencyUnit = currencyUnit;
    _transType = transType;
    _livingDays = livingDays;
    _price = price;
    _amountPrice = amountPrice;
    _realPayAmount = realPayAmount;
    _date = date;
    _remark = remark;
  }

  RoomRecord.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _roomNo = json['roomNo'];
    _payType = json['payType'];
    _roomType = json['roomType'];
    _currencyUnit = json['currencyUnit'];
    _transType = json['transType'];
    _livingDays = json['livingDays'];
    _price = json['price'];
    _amountPrice = json['amountPrice'];
    _realPayAmount = json['realPayAmount'];
    _date = json['date'];
    _remark = json['remark'].toString();
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
    String? transType,
    num? livingDays,
    num? price,
    num? amountPrice,
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
        transType: transType ?? _transType,
        livingDays: livingDays ?? _livingDays,
        price: price ?? _price,
        amountPrice: amountPrice ?? _amountPrice,
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
    map['transType'] = _transType;
    map['livingDays'] = _livingDays;
    map['price'] = _price;
    map['amountPrice'] = _amountPrice;
    map['realPayAmount'] = _realPayAmount;
    map['date'] = _date;
    map['remark'] = _remark;
    return map;
  }

  @override
  String toString() {
    return 'RoomRecord{_id: $_id, _roomNo: $_roomNo, _payType: $_payType, _roomType: $_roomType, _currencyUnit: $_currencyUnit, _transType: $_transType, _livingDays: $_livingDays, _price: $_price, _amountPrice: $_amountPrice, _realPayAmount: $_realPayAmount, _date: $_date, _remark: $_remark}';
  }

  List<String> toList() {
    return [
      _id.toString(),
      _roomNo.toString(),
      _payType.toString(),
      _roomType.toString(),
      _currencyUnit.toString(),
      _transType.toString(),
      _livingDays.toString(),
      _price.toString(),
      _amountPrice.toString(),
      _realPayAmount.toString(),
      TimeUtil.transMillToDate(millisconds: _date!.toInt()),
      _remark.toString()
    ];
  }
}
