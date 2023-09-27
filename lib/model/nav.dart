import 'package:flutter/cupertino.dart';

class Navigation {
  String _name;
  bool _isSelect;
  IconData _icon;

  Navigation(this._name, this._icon, this._isSelect);

  String get name => _name;

  bool get isSelect => _isSelect;

  IconData get icon => _icon;

  set isSelect(bool value) {
    _isSelect = value;
  }
}
