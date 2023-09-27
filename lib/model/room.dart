import 'package:flutter/cupertino.dart';

class Room {
  int _no;
  int _level;
  String _type;

  Room(this._no, this._level,this._type);

  int get no => _no;

  set no(int value) {
    _no = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }
}
