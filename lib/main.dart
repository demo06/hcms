import 'package:flutter/material.dart';
import 'package:hcms/page/home.dart';
import 'package:hcms/utils/db_open_helper.dart';
import 'package:hcms/utils/windows_setting.dart';

void main() async {
  WindowsSetting.initWindowsSetting();
  DBHelper.getInstance().initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
